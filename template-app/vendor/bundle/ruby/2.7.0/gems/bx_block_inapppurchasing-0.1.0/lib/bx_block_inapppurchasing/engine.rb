# frozen_string_literal: true

module BxBlockInapppurchasing
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockInapppurchasing
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_inapppurchasing.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockInapppurchasing::Engine => base + '/bx_block_inapppurchasing'
      end
    end
  end
end
