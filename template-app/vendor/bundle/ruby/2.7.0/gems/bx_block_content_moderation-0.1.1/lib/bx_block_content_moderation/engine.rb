# frozen_string_literal: true

module BxBlockContentModeration
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockContentModeration
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_content_moderation.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockContentModeration::Engine => base + '/bx_block_content_moderation'
      end
    end
  end
end
