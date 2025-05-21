# frozen_string_literal: true

module BxBlockTermsAndConditions
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockTermsAndConditions
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer "bx_block_terms_and_conditions.configuration" do |app|
      base = app.config.builder.root_url || ""
      app.routes.append do
        mount BxBlockTermsAndConditions::Engine => base + "/terms_and_conditions"
      end
    end
  end
end
