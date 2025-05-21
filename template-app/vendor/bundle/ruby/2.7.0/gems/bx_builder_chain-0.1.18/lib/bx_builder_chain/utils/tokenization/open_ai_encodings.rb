require 'base64'

module BxBuilderChain
  module Utils
    module Tokenization
      class OpenAiEncodings


        ENDOFTEXT = "<|endoftext|>"
        FIM_PREFIX = "<|fim_prefix|>"
        FIM_MIDDLE = "<|fim_middle|>"
        FIM_SUFFIX = "<|fim_suffix|>"
        ENDOFPROMPT = "<|endofprompt|>"

        def self.load_tiktoken_bpe(tiktoken_bpe_file)
          contents = File.read(tiktoken_bpe_file)
          contents.split("\n").each_with_object({}) do |line, hash|
            token, rank = line.split
            hash[Base64.decode64(token)] = rank.to_i
          end
        end

        def self.cl100k_base
          mergeable_ranks = load_tiktoken_bpe(File.join(__dir__, '..', 'token_data', 'cl100k_base.tiktoken'))

          special_tokens = {
            ENDOFTEXT => 100257,
            FIM_PREFIX => 100258,
            FIM_MIDDLE => 100259,
            FIM_SUFFIX => 100260,
            ENDOFPROMPT => 100276,
          }

          {
            "name" => "cl100k_base",
            "pat_str" => /(?i:'s|'t|'re|'ve|'m|'ll|'d)|[^\r\n\p{L}\p{N}]?\p{L}+|\p{N}{1,3}| ?[^\s\p{L}\p{N}]+[\r\n]*|\s*[\r\n]+|\s+(?!\S)|\s+/,
            "mergeable_ranks" => mergeable_ranks,
            "special_tokens" => special_tokens
          }
        end
      end
    end
  end
end