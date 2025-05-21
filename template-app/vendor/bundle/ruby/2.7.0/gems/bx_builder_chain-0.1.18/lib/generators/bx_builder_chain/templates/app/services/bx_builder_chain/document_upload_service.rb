module BxBuilderChain
    class DocumentUploadService
      attr_reader :files, :user_groups, :llm_class_name, :client_class_name

      WAITING_FOLDER = 'path/to/waiting_folder' # Update this path
  
      def initialize(files:, user_groups: ['public'], client_class_name: 'BxBuilderChain::Vectorsearch::Pgvector', llm_class_name: 'BxBuilderChain::Llm::OpenAi')
        @files = files
        @user_groups = user_groups
        @client_class_name = client_class_name
        @llm_class_name = llm_class_name
      end
  
      def upload_and_process
        return { error: 'No files provided' } unless @files&.any?
  
        files_n_paths = @files.map { |file| { path: file.tempfile.path, filename: file.original_filename } }
        client.add_data(paths: files_n_paths)
  
        { success: 'Files added to document store' }
      end
  
      def upload_and_process_later
        return { error: 'No files provided' } unless @files&.any?
  
        @files.each do |file|
          new_path = File.join(WAITING_FOLDER, file.original_filename)
          FileUtils.mv(file.tempfile.path, new_path)
          file_n_path = { path: new_path, filename: file.original_filename }
          # Enqueue for processing with Sidekiq
          BxBuilderChain::DocumentProcessorWorker.perform_async(file_n_path, llm_class: @llm_class_name, client_class: @client_class_name, namespaces: @user_groups)
        end
  
        { success: 'Files queued for processing' }
      end
  
      private
  
      def client
        @client ||= @client_class_name.constantize.new(
                          llm: @llm_class_name.constantize.new,
                          namespaces: @user_groups
                    )
      end
    end
  end
  