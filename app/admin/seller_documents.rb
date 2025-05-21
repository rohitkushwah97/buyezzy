ActiveAdmin.register AccountBlock::SellerDocument, as: 'SellerDocument' do

  before_action :update_approved, only: [:update]
  permit_params :approved, :rejected, :reason_for_rejection, :document_type

  index do
    selectable_column
    id_column
    column :account_id
    column :document_type
    column :approved
    column :rejected
    actions
  end

  show do
    attributes_table do
      row :account_id
      row :document_type
      row :document_name
      if seller_document.document_type == "VAT Certificate or Reason for not having it"
        row :vat_reason
      end
      if seller_document.document_type == "IBAN Certificate or Bank Details"
        row :account_no
        row :iban
        row :bank_address
        row :name
        row :bank_name
        row :swift_code
      end
      row :document_files do |seller_document|
        ul do
          seller_document.document_files.each do |file|
            li link_to(file.filename, url_for(file), target: '_blank')
          end
        end
      end
      row :approved
      row :rejected
      row :reason_for_rejection
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :approved, as: :boolean
      f.input :rejected, as: :boolean
      
      li do
        f.input :reason_for_rejection, as: :text, rows: 4,style: 'float: left;clear: both;'
      end

    end
    f.actions do
      f.action :submit, label: 'Update'
      f.cancel_link(admin_seller_account_path(f.object.account))
    end
  end


  controller do
    def update_approved
      seller_document = AccountBlock::SellerDocument.find(params[:id])
      if seller_document.update(permitted_params[:seller_document])
        redirect_to admin_seller_account_path(seller_document.account), notice: 'Document updated successfully.'
      else
        flash[:error] = seller_document.errors.full_messages.join(", ")
        render :edit
      end
    end
  end
  menu if: proc { false }
end
