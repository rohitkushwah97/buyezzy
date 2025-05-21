# frozen_string_literal: true

module BxBlockAddfriends
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockAddfriends
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_addfriends.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockAddfriends::Engine => base + '/bx_block_addfriends'
      end
    end
  end
end
