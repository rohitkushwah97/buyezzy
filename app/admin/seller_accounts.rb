ActiveAdmin.register AccountBlock::Account, as: "Seller Account" do

  scope "Seller Accounts", :seller_accounts, default: true do |accounts|
    accounts.where(user_type: 'seller')
  end

  permit_params :first_name, :last_name, :full_phone_number, :phone_number, :user_type, :email, :gender, :date_of_birth, :age, :activated, :language

  def seller_filters
    filter :first_name
    filter :last_name
    filter :full_phone_number
    filter :phone_number
    filter :email
    filter :company_or_store_name
    filter :language, as: :select, collection: [['English', 'english']]
    filter :activated
    filter :created_at, as: :date_range
    filter :updated_at, as: :date_range
  end

  seller_filters

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :full_phone_number
    column :user_type
    column :activated
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Seller Details' do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :full_phone_number
      f.input :company_or_store_name, label: "Company / Store Name"
      f.input :user_type, as: :select, collection: ['seller', 'buyer']
      f.input :language, as: :select, collection: ['English']
      f.input :activated, as: :select, collection: [['Yes', true], ['No', false]]
    end
    f.actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :email
          row :first_name
          row :last_name
          row :full_phone_number
          row :phone_number
          row :company_or_store_name
          row :user_type
          row :language
          row :activated
          row :created_at
          row :updated_at
        end
      end

      column do
        panel "Seller Documents" do
          table_for seller_account.seller_documents.order(created_at: :asc) do
            column :document_type
            column :document_name
            column :approved
            column :rejected
            column :actions do |seller_document|
              link_to "View", admin_seller_document_path(seller_document)
            end
          end
        end
      end

    end
  end

  controller do
    def destroy
      @seller_account = AccountBlock::Account.find(params[:id])
      @flash_error_alert = "Cannot delete seller account. Please delete associated products and brands."
      if @seller_account.destroy
        flash[:notice] = "Seller account successfully deleted."
      else
        flash[:alert] = @flash_error_alert
      end
      redirect_to admin_seller_accounts_path
    rescue ActiveRecord::InvalidForeignKey
      flash[:alert] = @flash_error_alert
      redirect_to admin_seller_accounts_path
    end
  end
end