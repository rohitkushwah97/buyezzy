# frozen_string_literal: true

module BxBlockWishlist
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockWishlist
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_wishlist.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockWishlist::Engine => base + '/bx_block_wishlist'
      end
    end
  end
end
