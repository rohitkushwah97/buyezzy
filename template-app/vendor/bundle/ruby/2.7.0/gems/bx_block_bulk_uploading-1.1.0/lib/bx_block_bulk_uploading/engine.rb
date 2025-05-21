# frozen_string_literal: true

module BxBlockBulkUploading
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockBulkUploading
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer "bx_block_bulk_uploading.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockBulkUploading::Engine => "#{base}/bulk_uploading"
      end
    end
  end
end
