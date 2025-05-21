ActiveAdmin.register AccountBlock::BusinessUser, as: 'Business Users' do
  filter :email
  filter :activated
  menu label: 'Business Users', parent: 'Users', priority: 2

  permit_params :email, :password, :full_phone_number, :full_name,
                company_detail_attributes: [
                  :id, :country_id, :city_id, :industry_id, :company_name,
                  :website_link, :contact_number, :address,:device_id,
                  :company_description, :update_by,:photo
                ]

  after_create do
    AccountBlock::AccountActivationMailer.with(account: @business_users).activation_email.deliver_now if @business_users.id.present?
  end

  index do
    selectable_column
    id_column
    column :email
    column :activated
    column :is_blacklisted
    column "" do |business_user|
      link_to business_user.is_blacklisted? ? 'Unblock' : 'Block', block_unblock_business_user_admin_business_user_path(business_user), method: :put,class: "button #{business_user.is_blacklisted? ? 'unblock' : 'block'}"
    end
    column 'created_at' do |obj|
      obj.created_at.in_time_zone
    end
    column 'updated_at' do |obj|
      obj.updated_at.in_time_zone
    end
    actions
  end

  show do
    attributes_table do
      row :email
      row :activated
      row :is_blacklisted
      row "Country",:country_id do |object|
       @company_detail = object.company_detail
       @company_detail&.country&.name
      end
      row "City",:city_id do |object|
       @company_detail&.city&.name
      end
      row "Industry",:industry_id do |object|
       @company_detail&.industry&.name
      end
      row "Company Name",:company_name do |object|
       @company_detail&.company_name
      end
      row "Website Link",:website_link do |object|
       @company_detail&.website_link
      end
      row "Contact Number",:contact_number do |object|
       @company_detail&.contact_number
      end
      row "Address",:address do |object|
       @company_detail&.address
      end
      row "Company Description",:company_description do |object|
       @company_detail&.company_description
      end
      row "Company photo",:photo do |object|
       image_tag url_for(@company_detail&.photo), size: '100x100' if @company_detail&.photo.present?
      end
      row :device_id
    end
    panel "Internships" do
      table_for resource.internships do
        column :title
        column :start_date
        column :end_date
        column :monthly_salary
        column "Questions" do |internship|
          html = internship.intern_user_generic_questions.map do |question|
            content_tag(:li, question.question)
          end.join.html_safe
          raw(html)
        end
        column "Generic Answers" do |internship|
          link_to "Answers", intern_user_generic_questions_bx_block_surveys_intern_user_generic_questions_path(internship.id)
        end
        column 'Applicants' do |internship|
          link_to "applicants", get_applicants_bx_block_surveys_intern_user_generic_questions_path(internship.id)
        end
      end
    end
  end

  form do |f|
    f.inputs 'Business User' do
      f.input :email
      f.input :password
      if f.object.persisted?
        company_detail = object&.company_detail
        if company_detail.present?
          f.inputs '', for: [:company_detail, f.object.company_detail || BxBlockProfile::CompanyDetail.new] do |company_detail_form|
            company_detail_form.input :country_id, label: "Country", as: :select,
                    collection: AccountBlock::Country.all.pluck(:name, :id),
                    include_blank: "Select Country",
                    input_html: { id: 'country_select' }

            company_detail_form.input :city_id, label: "City", as: :select,
                    collection: AccountBlock::City.all.pluck(:name, :id),
                    include_blank: "Select City",
                    input_html: { id: 'city_select' }

            @cities = company_detail.city_id.present? ? AccountBlock::City.order(Arel.sql("id = #{company_detail.city_id} DESC")) : AccountBlock::City.all
            company_detail_form.input :all_cities, as: :hidden, input_html: { value: @cities.to_json, id: 'all_cities' }
            company_detail_form.input :industry_id, label: "Industry", as: :select,
                                      collection: BxBlockCategories::Industry.all.pluck(:name, :id)

            company_detail_form.input :company_name
            company_detail_form.input :contact_number
            company_detail_form.input :address
            company_detail_form.input :company_description
            company_detail_form.input :website_link
            company_detail_form.input :photo, :as => :file
          end
        end
      end
    end
    f.actions
  end

  member_action :block_unblock_business_user, method: :put do
    business_user = AccountBlock::BusinessUser.find(params[:id])
    business_user.update(is_blacklisted: !business_user.is_blacklisted)
    if business_user.is_blacklisted?
      AccountBlock::AccountActivationMailer.with(
        otp: business_user,
        host: request.base_url
      ).ban_account.deliver_now
    end
    redirect_to admin_business_users_path, notice: "Business User #{business_user.is_blacklisted? ? 'blocked' : 'unblocked'} successfully."
  end

  action_item :csv_actions, only: :index do
    dropdown_menu 'CSV Actions' do
      item 'Import CSV', action: 'upload_csv'
      item 'Template', action: 'download_template'
    end
  end

  collection_action :upload_csv do
    render 'account_block/business_users/_csv_upload'
  end

  collection_action :import_csv, method: :post do
    csv_file = params[:csv_file]

    if csv_file.nil?
      BxBlockNotifications::AdminNotification.create(
        message: 'CSV import failed: No file selected.'
      )
      redirect_to admin_business_users_path, alert: "Please select a CSV file to upload."
      return
    end

    BxBlockAdmin::CsvImportJob.perform_later(csv_file.read, 'AccountBlock::BusinessUser')

    redirect_to admin_business_users_path, notice: 'Bulk upload has started. Please check notifications tab for updates'
  end

  collection_action :download_template, method: :get do
    template_path = Rails.root.join('public/admin/tamplate.csv')
    send_file template_path, type: 'text/csv', filename: 'template.csv'
  end

  controller do
    before_action :set_default_status, only: [:update, :create]

    private

    def set_default_status
      params[:business_user][:company_detail_attributes][:update_by] = "admin" if params.dig(:business_user, :company_detail_attributes)
    end
  end
end
