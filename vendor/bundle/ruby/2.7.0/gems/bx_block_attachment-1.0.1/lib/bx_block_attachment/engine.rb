# frozen_string_literal: true

module BxBlockAttachment
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockAttachment
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_attachment.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockAttachment::Engine => base + '/attachment'
      end
    end
  end
end
