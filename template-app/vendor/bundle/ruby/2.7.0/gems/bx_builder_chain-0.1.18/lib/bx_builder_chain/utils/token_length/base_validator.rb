# frozen_string_literal: true

module BxBuilderChain
  module Utils
    module TokenLength
      #
      # Calculate the `max_tokens:` parameter to be set by calculating the context length of the text minus the prompt length
      #
      # @param content [String | Array<String>] The text or array of texts to validate
      # @param model_name [String] The model name to validate against
      # @return [Integer] Whether the text is valid or not
      # @raise [TokenLimitExceeded] If the text is too long
      #
      class BaseValidator
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
          start_time = Time.new.to_f * 1000
          settings = BxBuilderChain::Utils::Tokenization::OpenAiEncodings.cl100k_base
          puts "loading 100k_base = #{(Time.new.to_f * 1000) - start_time}"
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
