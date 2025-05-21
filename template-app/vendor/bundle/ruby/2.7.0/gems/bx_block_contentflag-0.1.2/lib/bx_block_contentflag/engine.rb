# frozen_string_literal: true

module BxBlockContentflag
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockContentflag
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer "bx_block_contentflag.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockContentflag::Engine => base + "/bx_block_contentflag"
      end
    end
  end
end
