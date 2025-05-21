# frozen_string_literal: true

module BxBlockLikeAPost
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockLikeAPost
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_like_a_post.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockLikeAPost::Engine => base + '/like_a_post'
      end
    end
  end
end
