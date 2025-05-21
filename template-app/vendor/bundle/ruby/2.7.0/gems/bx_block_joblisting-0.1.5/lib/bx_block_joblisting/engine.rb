# frozen_string_literal: true

module BxBlockJoblisting
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockJoblisting
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_joblisting.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockJoblisting::Engine => base + '/bx_block_joblisting'
      end
    end
  end
end
