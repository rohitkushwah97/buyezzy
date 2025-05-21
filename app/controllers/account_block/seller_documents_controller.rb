module AccountBlock
  class SellerDocumentsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token
    before_action :current_user
    before_action :set_seller_document, only: [:show, :update]


    def index
      @seller_documents = @current_user.seller_documents.all
        render json: SellerDocumentSerializer.new(@seller_documents, meta: {
         message: "Successfully Loaded"
       }).serializable_hash, status: :ok
    end


    def show
      if @seller_document.present?
        render json: SellerDocumentSerializer.new(@seller_document).serializable_hash, status: :ok
      else
        render json: {errors: "No Seller Document found"}, status: :ok
      end
    end


    def create
      @seller_document = SellerDocument.new(seller_document_params.merge(account_id: @current_user.id))
      if @seller_document.save
        render json: SellerDocumentSerializer.new(@seller_document).serializable_hash, status: :created
      else
        render json: @seller_document.errors, status: :unprocessable_entity
      end
    end


    def update
      if @seller_document.update(seller_document_params.merge({approved: nil,rejected: nil,reason_for_rejection: nil}))
        render json: SellerDocumentSerializer.new(@seller_document, meta: {
         message: "Updated Successfully"
       }).serializable_hash
      else
        render json: @seller_document.errors, status: :unprocessable_entity
      end
    end

    def document_verification_email
      admin_email = params[:admin_email].present? ? params[:admin_email] : 'admin@byezzy.com'
      account = Account.find_by(id: @token&.id, user_type: 'seller')
      if account.present?
        begin
        BxBlockEmailNotifications::SendEmailNotificationService
            .with(account: account, subject: 'Verification of Uploaded Documents', file: 'document_verification_notification')
            .notification.deliver_now

        BxBlockEmailNotifications::SendEmailNotificationService
            .with(to: admin_email, subject: "Vendor's Document Submitted", file: 'document_submitted_notification')
            .notification.deliver_now

        render json: { message: "Document verification email sent" }, status: :ok

        rescue => e
          Rails.logger.error "Email sending failed: #{e.message}"
          render json: { message: "Failed to send email: #{e.message}" }, status: :unprocessable_entity
        end
      else
        render json: { message: "User not found"}, status: :unprocessable_entity
      end
    end


    private

    def current_user
      @current_user = Account.find_by(id: params[:account_id])
    end

    def set_seller_document
      @seller_document = @current_user.seller_documents.find_by(id: params[:id])
    end

    def seller_document_params
      params.permit(
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
        :account_id,
        document_files: []).tap do |allowed_params|
        allowed_params[:document_files] = nil if allowed_params[:document_files].blank?
      end
    end

  end
end