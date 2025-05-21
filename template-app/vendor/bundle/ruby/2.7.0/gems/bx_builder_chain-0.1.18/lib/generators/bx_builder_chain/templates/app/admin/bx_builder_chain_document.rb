ActiveAdmin.register BxBuilderChain::Document, as: "Document Embeddings" do
  permit_params :name, :namespace

  controller do
    def scoped_collection
      super.includes(:document_chunks)
    end

    def create

      uploaded_files = params[:bx_builder_chain_document][:files]
      namespace = params[:bx_builder_chain_document][:namespace]

      user_groups = namespace.to_s.split(',').reject(&:blank?)

      service = BxBuilderChain::DocumentUploadService.new(
        files: uploaded_files,
        user_groups: user_groups,
        client_class_name: 'BxBuilderChain::Vectorsearch::Pgvector',
        llm_class_name: 'BxBuilderChain::Llm::OpenAi'
      )
      result = service.upload_and_process

      if result[:error]
        flash.now[:error] = JSON.parse(response.body)["error"]
        render :new
      else
        redirect_to admin_document_embeddings_path, notice: 'Document uploaded and processed successfully.'
      end
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :namespace
    column "Document Chunks" do |document|
      document.document_chunks.size
    end
    column :created_at

    # # Custom actions
    # actions defaults: false do |document|
    #   link_to 'Delete', admin_bx_builder_chain_document_path(document), method: :delete, data: { confirm: 'Are you sure?' }
    # end
    actions
  end

  filter :name
  filter :namespace
  filter :created_at

  form html: { multipart: true } do |f|
    f.inputs do
      if f.object.new_record?
        f.input :files, as: :file, input_html: { multiple: true }
      else
        f.input :name, as: :string, input_html: { disabled: true }
      end
      f.input :namespace, as: :string
    end
    f.actions
  end
end
