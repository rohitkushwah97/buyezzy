# frozen_string_literal: true

module BxBlockRecommendation
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockRecommendation
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_recommendation.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockRecommendation::Engine => base + '/bx_block_recommendation'
      end
    end
  end
end
