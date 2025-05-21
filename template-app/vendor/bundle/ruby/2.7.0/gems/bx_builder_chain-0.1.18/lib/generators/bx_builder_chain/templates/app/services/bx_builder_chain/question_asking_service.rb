module BxBuilderChain
    class QuestionAskingService
      attr_reader :question, :user_groups, :llm_class_name, :client_class_name, :context_results

      def initialize(question:, user_groups: ['public'], client_class_name: 'BxBuilderChain::Vectorsearch::Pgvector', llm_class_name: 'BxBuilderChain::Llm::OpenAi', context_results: 6, model: "gpt-3.5-turbo-16k")
        @question = question
        @user_groups = user_groups
        @client_class_name = client_class_name
        @llm_class_name = llm_class_name
        @context_results = context_results
        @model = model
      end
  
      def ask
        return { error: 'No question provided' } unless question.present?
  
        response = client.ask(question: question, context_results: context_results)
        { answer: response }
      end

      # history in the format of
      # [{role:'human', message:'user message', {role:'ai',message:'some text'}, .....]
      def chat(history = [])
        search_results = client.similarity_search(query: @question, k: @context_results)

        context = search_results.map do |result|
          result.content.to_s
        end
        context = context.join("\n---\n")
  
        prompt = client.generate_prompt(question: @question, context: context, prompt_template: nil)
  
        llm.chat(prompt:prompt, messages: reduce_history(history))
      end

      def reduce_history(history)
        current_length = 0
        limit = tokenizer.class::TOKEN_LIMITS["gpt-3.5-turbo-16k"] * 0.75
        history_overflow, @reduced_history = @history.partition do |msg|
          current_length += tokenizer.token_length(msg[:message], @current_model)
          current_length > limit
        end

        reduced_history
      end

      private

      def tokenizer
        @tokenizer ||= llm.class::LENGTH_VALIDATOR
      end
      
      def client
        @client ||= client_class_name.constantize.new(
          llm: llm,
          namespaces: user_groups
        )
      end

      def llm
        @llm ||= llm_class_name.constantize.new(
          default_options: {
            chat_completion_model_name: "gpt-3.5-turbo-16k", 
            temperature: 0.2
          }
        )
      end
    end
  end
  