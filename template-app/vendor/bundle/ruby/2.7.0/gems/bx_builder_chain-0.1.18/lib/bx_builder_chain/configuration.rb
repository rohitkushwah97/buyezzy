# In your Configuration class (e.g., `lib/bx_builder_chain/vectorsearch/configuration.rb`)

module BxBuilderChain
  class Configuration
    attr_accessor :pg_url, :openai_api_key, :public_namespace, :threshold, 
                  :default_prompt_template, :database_host, :database_port, :database_name, 
                  :database_user, :database_password

    def initialize
      @pg_url = ENV['DB_URL'] || nil
      @openai_api_key = ENV['OPENAI_API_KEY']
      @public_namespace = 'public'
      @threshold = 0.25
      @default_prompt_template = "Context information is below
--------------------
%{context}
--------------------
Given the context information and not prior knowledge
answer the question: %{question}"
      @database_host = ENV['DB_HOSTNAME']
      @database_port = ENV['DB_PORT']
      @database_name = ENV['DB_NAME']
      @database_user = ENV['DB_USER']
      @database_password = ENV['DB_PASSWORD']
    end
  end
end