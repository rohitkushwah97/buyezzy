# frozen_string_literal: true

module BxBlockNavmenu
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockNavmenu
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_navmenu.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockNavmenu::Engine => base + '/navmenu'
      end
    end
  end
end
