ActiveAdmin.register AccountBlock::InternUser, as: 'Intern Users' do
  before_action :set_update_by, only: [:create, :update]
  filter :date_of_birth
  filter :email
  filter :activated
  menu label: 'Intern Users', parent: 'Users', priority: 2
  permit_params :date_of_birth,  :email, :password,:full_phone_number,
                :full_name,:update_by,:is_blacklisted,:device_id,
                profile_attributes: [:id, :country_id, :city_id, :photo]

  after_create do
    AccountBlock::AccountActivationMailer.with(account: @intern_users).activation_email.deliver_now if @intern_users.id.present?
  end
  
  index do
    selectable_column
    id_column
    column :date_of_birth
    column :email
    column :activated
    column :is_blacklisted
    column "" do |intern_user|
      link_to intern_user.is_blacklisted? ? 'Unblock' : 'Block', block_unblock_intern_user_admin_intern_user_path(intern_user), method: :put,class: "button #{intern_user.is_blacklisted? ? 'unblock' : 'block'}"
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
      row :full_name
      row :email
      row :full_phone_number
      row :date_of_birth
      row :activated
      row :is_blacklisted
      row "Country",:country_id do |object|
       @profile = object.profile
       @profile&.country&.name
      end
      row "City",:city_id do |object|
       @profile&.city&.name
      end
      row "Profile photo",:photo do |object|
       image_tag url_for(@profile&.photo), size: '100x100' if @profile&.photo.present?
      end
      row :device_id
    end
    panel "Actions" do
      link_to "Applied Internship", get_intern_user_internships_account_block_intern_user_path(id: resource.id)
    end
    panel "" do
      link_to "Education background", education_details_account_block_intern_user_path(id: resource.id)
    end
    panel "" do
      link_to "Career Interests", career_interests_account_block_intern_user_path(id: resource.id)
    end
  end

  form do |f|
    f.inputs 'Intern User' do
      f.input :email 
      f.input :password
      f.input :date_of_birth, :as => :datepicker,
      datepicker_options: {
        dateFormat: "dd/mm/yy",
        change_year: true,
        change_month: true, 
        max_date: '+0d',                
        year_range: "#{Time.now.year - 100}:#{Time.now.year}"
      }
      
      if f.object.persisted?
        f.input :full_name
        f.input :full_phone_number
        profile = object&.profile
        if profile.present?
          f.inputs '', for: [:profile, f.object.profile || BxBlockProfile::Profile.new] do |profile_form|
            profile_form.input :country_id, label: "Country", as: :select,
                    collection: AccountBlock::Country.all.pluck(:name, :id),
                    include_blank: "Select Country",
                    input_html: { id: 'country_select' }

            profile_form.input :city_id, label: "City", as: :select,
                    collection: AccountBlock::City.all.pluck(:name, :id),
                    include_blank: "Select City",
                    input_html: { id: 'city_select' }
            @cities = profile.city_id.present? ? AccountBlock::City.order(Arel.sql("id = #{profile.city_id} DESC")) : AccountBlock::City.all
            profile_form.input :all_cities, as: :hidden, input_html: { value: @cities.to_json, id: 'all_cities' }
            profile_form.input :photo, :as => :file
          end
        end
      end
    end
    f.actions
  end

  action_item :csv_actions, only: :index do
    dropdown_menu 'CSV Actions' do
      item 'Import CSV', action: 'upload_csv'
      item 'Template', action: 'download_template'
    end
  end

  member_action :block_unblock_intern_user, method: :put do
    intern_user = AccountBlock::InternUser.find(params[:id])
    intern_user.update(is_blacklisted: !intern_user.is_blacklisted)
    if intern_user.is_blacklisted?
      AccountBlock::AccountActivationMailer.with(
        otp: intern_user,
        host: request.base_url
      ).ban_account.deliver_now
    end
    redirect_to admin_intern_users_path, notice: "Intern User #{intern_user.is_blacklisted? ? 'blocked' : 'unblocked'} successfully."
  end

  collection_action :upload_csv do
      render 'account_block/intern_users/_intern_csv_upload'
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
    BxBlockAdmin::ImportInternJob.perform_later(csv_file.read, 'AccountBlock::InternUser')

    redirect_to admin_intern_users_path, notice: 'Bulk upload has started. Please check notifications tab for updates'
  end


  collection_action :download_template, method: :get do
    template_path = Rails.root.join('public/admin/intern_template.csv')
    send_file template_path, type: 'text/csv', filename: 'template.csv'
  end

  controller do
    def set_update_by
      params[:intern_user][:update_by] = "admin"
    end
  end
end