module BxBuilderChain
  class DocumentsController < ::ApplicationController
    skip_before_action :verify_authenticity_token

    LLM_CLASS_NAME = 'BxBuilderChain::Llm::OpenAi'
    CLIENT_CLASS_NAME = 'BxBuilderChain::Vectorsearch::Pgvector'
    
    def namespace_documents
      documents = BxBuilderChain::Document.where(namespace: current_user_document_groups.first)
      render json: documents
    end

    def delete_documents
      return render json: { error: 'No document IDs provided' }, status: :bad_request unless params[:ids].present?
    
      documents_to_delete = BxBuilderChain::Document.where(id: params[:ids], namespace: current_user_document_groups.first)
      documents_to_delete.destroy_all
    
      render json: { success: 'Documents deleted successfully' }
    end

    def upload_and_process
      result = document_service.upload_and_process

      render_result(result)
    end

    def upload_and_process_later
      result = document_service.upload_and_process_later

      render_result(result)
    end

    private

    def render_result(result)
      if result[:error]
        render json: { error: result[:error] }, status: :bad_request
      else
        render json: result
      end
    end

    def document_service
      @service ||= DocumentUploadService.new(
        files: params[:files],
        user_groups: current_user_document_groups,
        client_class_name: CLIENT_CLASS_NAME,
        llm_class_name: LLM_CLASS_NAME
      )
    end

    def current_user_document_groups
      params[:current_user_groups].to_s.split(',').reject(&:blank?) 
      # replace this with the actual user document permission groups
    end   
  end
end
