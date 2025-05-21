# frozen_string_literal: true

module BxBlockPromoCodes
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockPromoCodes
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_promo_codes.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockPromoCodes::Engine => base + '/promo_codes'
      end
    end
  end
end
