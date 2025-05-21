# frozen_string_literal: true

require "rswag"
module BxBlockShare
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockShare
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer "bx_block_share.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockShare::Engine => base + "/share"
      end
    end
  end
end
