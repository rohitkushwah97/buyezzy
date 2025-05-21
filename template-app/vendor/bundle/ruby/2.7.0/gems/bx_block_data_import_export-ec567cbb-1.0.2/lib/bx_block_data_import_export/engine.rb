# frozen_string_literal: true

module BxBlockDataImportExport
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockDataImportExport
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_data_import_export.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockDataImportExport::Engine => base + '/data_import_export'
      end
    end
  end
end
