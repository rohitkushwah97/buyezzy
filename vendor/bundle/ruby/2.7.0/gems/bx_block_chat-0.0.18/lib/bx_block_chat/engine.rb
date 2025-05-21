# frozen_string_literal: true

module BxBlockChat
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockChat
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer "bx_block_chat.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockChat::Engine => base + "/chat"
      end
    end
  end
end
