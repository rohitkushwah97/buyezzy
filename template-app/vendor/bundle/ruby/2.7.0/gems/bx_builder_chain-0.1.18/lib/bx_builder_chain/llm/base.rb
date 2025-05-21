# frozen_string_literal: true

module BxBuilderChain::Llm
  class ApiError < StandardError; end

  # A LLM is a language model consisting of a neural network with many parameters (typically billions of weights or more), trained on large quantities of unlabeled text using self-supervised learning or semi-supervised learning.
  #
  # BxBuilderChain.rb provides a common interface to interact with all supported LLMs:
  #
  # - {BxBuilderChain::Llm::OpenAI}
  #
  # @abstract
  class Base
    include BxBuilderChain::DependencyHelper

    # A client for communicating with the LLM
    attr_reader :client

    def default_dimension
      self.class.const_get(:DEFAULTS).dig(:dimension)
    end

    #
    # Generate a chat completion for a given prompt. Parameters will depend on the LLM
    #
    # @raise NotImplementedError if not supported by the LLM
    def chat(**kwargs)
      raise NotImplementedError, "#{self.class.name} does not support chat"
    end

    #
    # Generate a completion for a given prompt. Parameters will depend on the LLM.
    #
    # @raise NotImplementedError if not supported by the LLM
    def complete(**kwargs)
      raise NotImplementedError, "#{self.class.name} does not support completion"
    end

    #
    # Generate an embedding for a given text. Parameters depends on the LLM.
    #
    # @raise NotImplementedError if not supported by the LLM
    #
    def embed(**kwargs)
      raise NotImplementedError, "#{self.class.name} does not support generating embeddings"
    end

    #
    # Generate a summary for a given text. Parameters depends on the LLM.
    #
    # @raise NotImplementedError if not supported by the LLM
    #
    def summarize(**kwargs)
      raise NotImplementedError, "#{self.class.name} does not support summarization"
    end

    def count_tokens(string)
      tokens = string.scan(/[\w]+|[\W]/)
      tokens = tokens.flat_map { |token| token.split(/(?<=[\W])$/) }

      return (tokens.length*1.07).to_i
    end
  end
end
