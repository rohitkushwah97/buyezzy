require 'sidekiq'

module BxBuilderChain
  class DocumentProcessorWorker
    include Sidekiq::Worker

    sidekiq_options retry: 2 

    def perform(file_data, llm_class:, client_class:, namespaces:)
      # Create a new instance of the service class
      service = DocumentUploadService.new(
        files: [file_data],
        user_groups: namespaces,
        client_class_name: client_class,
        llm_class_name: llm_class
      )

      # Use the service method to process the file
      result = service.upload_and_process

      # Log errors if they occur
      if result[:error]
        BxBuilderChain.logger.error("BxBuilderChain::DocumentProcessorWorker Error: #{result[:error]}\n File: #{file_data[:filename]}\nNameSpace: #{namespaces.join(', ')}")
      end

    rescue => e
        BxBuilderChain.logger.error("BxBuilderChain::DocumentProcessorWorker Error: #{e.message}\n File: #{file_data[:filename]}\nNameSpace: #{namespaces.join(', ')}")
        # Re-raise the exception to let Sidekiq handle retries
        raise e
    end
  end
end
