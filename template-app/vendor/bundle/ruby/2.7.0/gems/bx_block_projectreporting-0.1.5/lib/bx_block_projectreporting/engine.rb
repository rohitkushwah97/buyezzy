# frozen_string_literal: true

module BxBlockProjectreporting
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockProjectreporting
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_projectreporting.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockProjectreporting::Engine => base + '/bx_block_projectreporting'
      end
    end
  end
end
