# frozen_string_literal: true

module BxBuilderChain::Llm
  # LLM interface for OpenAI APIs: https://platform.openai.com/overview
  #
  # Gem requirements:
  #    gem "ruby-openai", "~> 4.0.0"
  #
  # Usage:
  #    openai = BxBuilderChain::LLM::OpenAI.new(api_key:, llm_options: {})
  #
  class OpenAi < Base
    DEFAULTS = {
      temperature: 0.0,
      completion_model_name: "text-davinci-003",
      chat_completion_model_name: "gpt-3.5-turbo",
      embeddings_model_name: "text-embedding-ada-002",
      dimension: 1536
    }.freeze
    LENGTH_VALIDATOR = BxBuilderChain::Utils::TokenLength::OpenAiValidator
    ROLE_MAPPING = {
      "ai" => "assistant",
      "human" => "user"
    }

    attr_accessor :functions

    def initialize(api_key: BxBuilderChain.configuration.openai_api_key, llm_options: {}, default_options: {})
      depends_on "ruby-openai"
      require "openai"

      @client = ::OpenAI::Client.new(access_token: api_key, **llm_options)
      @defaults = DEFAULTS.merge(default_options)
    end

    #
    # Generate an embedding for a given text
    #
    # @param text [String] The text to generate an embedding for
    # @param params extra parameters passed to OpenAI::Client#embeddings
    # @return [Array] The embedding
    #
    def embed(text:, **params)
      parameters = {model: @defaults[:embeddings_model_name], input: text}

      validate_max_tokens(text, parameters[:model])

      response = client.embeddings(parameters: parameters.merge(params))
      embedding = response.dig("data", 0, "embedding")

      return embedding if embedding

      puts response
      raise "Error: #{response.dig("data")}"

    end

    #
    # Generate a completion for a given prompt
    #
    # @param prompt [String] The prompt to generate a completion for
    # @param params  extra parameters passed to OpenAI::Client#complete
    # @return [String] The completion
    #
    def complete(prompt:, **params)
      parameters = compose_parameters @defaults[:completion_model_name], params

      parameters[:prompt] = prompt
      parameters[:max_tokens] = validate_max_tokens(prompt, parameters[:model])

      response = client.completions(parameters: parameters)
      response.dig("choices", 0, "text")
    end

    #
    # Generate a chat completion for a given prompt or messages.
    #
    # == Examples
    #
    #     # simplest case, just give a prompt
    #     openai.chat prompt: "When was Ruby first released?"
    #
    #     # prompt plus some context about how to respond
    #     openai.chat context: "You are RubyGPT, a helpful chat bot for helping people learn Ruby", prompt: "Does Ruby have a REPL like IPython?"
    #
    #     # full control over messages that get sent, equivilent to the above
    #     openai.chat messages: [
    #       {
    #         role: "system",
    #         content: "You are RubyGPT, a helpful chat bot for helping people learn Ruby", prompt: "Does Ruby have a REPL like IPython?"
    #       },
    #       {
    #         role: "user",
    #         content: "When was Ruby first released?"
    #       }
    #     ]
    #
    #     # few-short prompting with examples
    #     openai.chat prompt: "When was factory_bot released?",
    #       examples: [
    #         {
    #           role: "user",
    #           content: "When was Ruby on Rails released?"
    #         }
    #         {
    #           role: "assistant",
    #           content: "2004"
    #         },
    #       ]
    #
    # @param prompt [HumanMessage] The prompt to generate a chat completion for
    # @param messages [Array<AIMessage|HumanMessage>] The messages that have been sent in the conversation
    # @param context [SystemMessage] An initial context to provide as a system message, ie "You are RubyGPT, a helpful chat bot for helping people learn Ruby"
    # @param examples [Array<AIMessage|HumanMessage>] Examples of messages to provide to the model. Useful for Few-Shot Prompting
    # @param options [Hash] extra parameters passed to OpenAI::Client#chat
    # @yield [AIMessage] Stream responses back one String at a time
    # @return [AIMessage] The chat completion
    #
    def chat(prompt: "", messages: [], context: "", examples: [], **options)
      raise ArgumentError.new(":prompt or :messages argument is expected") if prompt.empty? && messages.empty?

      parameters = compose_parameters @defaults[:chat_completion_model_name], options
      parameters[:messages] = compose_chat_messages(prompt: prompt, messages: messages, context: context, examples: examples)

      if functions
        parameters[:functions] = functions
      else
        parameters[:max_tokens] = validate_max_tokens(parameters[:messages], parameters[:model])
      end

      response = client.chat(parameters: parameters)
      
      response.dig("choices", 0, "message", "content")
    end

    #
    # Generate a summary for a given text
    #
    # @param text [String] The text to generate a summary for
    # @return [String] The summary
    #
    # def summarize(text:)
    #   prompt_template = BxBuilderChain::Prompt.load_from_path(
    #     file_path: BxBuilderChain.root.join("langchain/llm/prompts/summarize_template.yaml")
    #   )
    #   prompt = prompt_template.format(text: text)

    #   complete(prompt: prompt, temperature: @defaults[:temperature])
    # end

    private

    def compose_parameters(model, params)
      default_params = {model: model, temperature: @defaults[:temperature]}

      default_params[:stop] = params.delete(:stop_sequences) if params[:stop_sequences]

      default_params.merge(params)
    end

    def compose_chat_messages(prompt:, messages:, context:, examples:)
      history = []

      history.concat transform_messages(examples) unless examples.empty?

      history.concat transform_messages(messages) unless messages.empty?

      unless context.nil? || context.to_s.empty?
        history.reject! { |message| message[:role] == "system" }
        history.prepend({role: "system", content: context.content})
      end

      unless prompt.empty?
        if history.last && history.last[:role] == "user"
          history.last[:content] += "\n#{prompt}"
        else
          history.append({role: "user", content: prompt})
        end
      end

      history
    end

    def transform_messages(messages)
      messages.map do |message|
        {
          role: ROLE_MAPPING.fetch(message[:type], message[:type]),
          content: message[:message]
        }
      end
    end

    def validate_max_tokens(messages, model)
      LENGTH_VALIDATOR.validate_max_tokens!(messages, model)
    end
  end
end
