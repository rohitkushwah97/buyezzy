BxBuilderChain.configure do |config|
  begin
    config.openai_api_key = ENV['OPENAI_API_KEY']

    # for db use this
    config.pg_url = ENV['DB_URL'] || nil # eg 'postgres://postgres:password@localhost:5432/my_db'
  
    # or this - pg_url with take preference
    config.database_host = ENV['TEMPLATE_DATABASE_HOSTNAME'] || 'localhost'
    config.database_name = ENV['TEMPLATEAPP_DATABASE']
    config.database_user = ENV['TEMPLATEAPP_DATABASE_USER']
    config.database_password = ENV['TEMPLATEAPP_DATABASE_PASSWORD']
    config.database_port = '5432'

    config.public_namespace = "public" # namespace everyone has access to
    config.threshold = 0.25 # return content with a match of less than this.
    config.default_prompt_template = "Context information is below
    --------------------
    %{context}
    --------------------
    Given the context information and not prior knowledge
    answer the question: %{question}"
  rescue StandardError => e
    logger.error("Failed to set configuration: #{e.message}")
  end
end
