module BxBuilderChain
  class QuestionsController < ::ApplicationController
    skip_before_action :verify_authenticity_token

    LLM_CLASS_NAME = 'BxBuilderChain::Llm::OpenAi'
    CLIENT_CLASS_NAME = 'BxBuilderChain::Vectorsearch::Pgvector'

    # POST /bx_builder_chain/ask
    def ask
      service = QuestionAskingService.new(
        question: params[:question],
        user_groups: current_user_document_groups, # optional defaults to ['public']
        client_class_name: CLIENT_CLASS_NAME, # optional defaults to 'BxBuilderChain::Vectorsearch::Pgvector'
        llm_class_name: LLM_CLASS_NAME, # optional defaults to 'BxBuilderChain::Llm::OpenAi'
        context_results: 10 # optional defaults to 6
      )
      response = service.ask

      if response[:error]
        render json: response, status: :bad_request
      else
        render json: response
      end
    end

    private

    def current_user_document_groups 
      params[:current_user_groups].to_s.split(',').reject(&:blank?) 
      # replace this with the actual user document permission groups
    end
  end
end
