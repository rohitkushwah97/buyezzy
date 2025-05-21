# frozen_string_literal: true

BxBlockCategories::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)
  resources :categories do
    collection do
      put "update_user_categories"
    end
  end
  resources :sub_categories do
    collection do
      put "update_user_sub_categories"
    end
  end
  resources :cta, only: %i[index]
end
