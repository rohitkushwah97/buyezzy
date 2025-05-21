# frozen_string_literal: true

module BxBlockSearch
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockSearch

    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_search.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockSearch::Engine => base + '/search'
      end
    end
  end
end
