module BxBlockSupport
  class SupportDocumentsController < ApplicationController
    before_action :set_support_document, only: [:show]

    def index
      @support_documents = SupportDocument.all

      render json: @support_documents
    end

    def show
      render json: @support_document
    end

    def delete_support_documents
       if params[:ids].present?
        documents = SupportDocument.where(id: params[:ids])
        if documents.destroy_all
          render json: { message: 'Documents deleted successfully' }, status: :ok
        end
      else
        render json: { error: 'No IDs provided' }, status: :unprocessable_entity
      end
    end

    private
    
    def set_support_document
      @support_document = SupportDocument.find(params[:id])
    end

  end
end