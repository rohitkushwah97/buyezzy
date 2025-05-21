# frozen_string_literal: true

module BxBlockNotifsettings
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockNotifsettings
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_notifsettings.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockNotifsettings::Engine => base + '/notifsettings'
      end
    end
  end
end
