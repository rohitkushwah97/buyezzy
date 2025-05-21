module AccountBlock
  class SellerDocumentSerializer < BuilderBase::BaseSerializer
     include FastJsonapi::ObjectSerializer
     attributes *[
      :document_type, 
      :document_name, 
      :vat_reason, 
      :account_no,
      :iban, 
      :bank_address, 
      :name, 
      :bank_name, 
      :swift_code, 
      :approved, 
      :rejected,
      :reason_for_rejection,
      :created_at,
      :account_id
    ]

    attributes :document_files do |object|
      if object.document_files.attached?
        object.document_files.map { |file| ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(file.blob, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(file.blob, only_path: true) }.compact
      end

    end
 end
end