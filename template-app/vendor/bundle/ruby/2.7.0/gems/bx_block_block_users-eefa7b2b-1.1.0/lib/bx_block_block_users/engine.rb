# frozen_string_literal: true

module BxBlockBlockUsers
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockBlockUsers
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_block_users.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockBlockUsers::Engine => base + '/block_users'
      end
    end
  end
end
