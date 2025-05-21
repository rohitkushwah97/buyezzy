# frozen_string_literal: true

BxBlockAdvancedSearch::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)

  get "search", action: :filter, controller: "search"
end
