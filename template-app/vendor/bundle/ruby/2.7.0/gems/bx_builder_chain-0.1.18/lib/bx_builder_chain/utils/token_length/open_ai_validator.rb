# frozen_string_literal: true

module BxBuilderChain
  module Utils
    module TokenLength
      #
      # This class is meant to validate the length of the text passed in to OpenAI's API.
      # It is used to validate the token length before the API call is made
      #
      class OpenAiValidator < BaseValidator
        TOKEN_LIMITS = {
          # Source:
          # https://platform.openai.com/docs/api-reference/embeddings
          # https://platform.openai.com/docs/models/gpt-4
          "text-embedding-ada-002" => 8191,
          "gpt-3.5-turbo" => 4096,
          "gpt-3.5-turbo-0301" => 4096,
          "gpt-3.5-turbo-0613" => 4096,
          "gpt-3.5-turbo-16k" => 16384,
          "gpt-3.5-turbo-16k-0613" => 16384,
          "text-davinci-003" => 4097,
          "text-davinci-002" => 4097,
          "code-davinci-002" => 8001,
          "gpt-4" => 8192,
          "gpt-4-0314" => 8192,
          "gpt-4-0613" => 8192,
          "gpt-4-32k" => 32768,
          "gpt-4-32k-0314" => 32768,
          "gpt-4-32k-0613" => 32768,
          "text-curie-001" => 2049,
          "text-babbage-001" => 2049,
          "text-ada-001" => 2049,
          "davinci" => 2049,
          "curie" => 2049,
          "babbage" => 2049,
          "ada" => 2049
        }.freeze

        def self.token_limit(model_name)
          TOKEN_LIMITS[model_name]
        end
        
        def self.validate_max_tokens!(content, model_name, options = {})
          text_token_length = if content.is_a?(Array)
            content.sum { |item| token_length(item.to_json, model_name, options) }
          else
            token_length(content, model_name, options)
          end

          leftover_tokens = token_limit(model_name) - text_token_length

          if leftover_tokens < 0
            raise "This model's maximum context length is #{token_limit(model_name)} tokens, but the given text is #{text_token_length} tokens long."
          end

          leftover_tokens
        end

        def self.token_length(text, model_name = "", options = {})
          settings = BxBuilderChain::Utils::Tokenization::OpenAiEncodings.cl100k_base
          encoder = BxBuilderChain::Utils::Tokenization::BytePairEncoding.new(
            pat_str: settings["pat_str"],
            mergeable_ranks: settings["mergeable_ranks"]
          )
          
          encoder.encode(text).count
        end
      end
    end
  end
end
