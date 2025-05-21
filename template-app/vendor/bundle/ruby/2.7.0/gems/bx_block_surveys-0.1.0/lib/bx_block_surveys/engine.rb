# frozen_string_literal: true

module BxBlockSurveys
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockSurveys
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_surveys.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockSurveys::Engine => base + '/bx_block_surveys'
      end
    end
  end
end
