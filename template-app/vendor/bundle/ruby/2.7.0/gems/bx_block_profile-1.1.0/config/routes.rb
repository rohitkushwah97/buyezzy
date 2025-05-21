# frozen_string_literal: true

BxBlockProfile::Engine.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Api)
  resource :profile, only: [:update]
  put '/account', to: 'profiles#update'
  get 'profile/:id', to: 'profiles#show'
  resource :password, only: [:update]
  resource :change_phone_validation, only: [:create]
  resources :validations, only: [:index]

  get 'user_profiles', to: 'profiles#user_profiles'
  resources :profiles, only: %i[create show destroy index] do
    put :update_profile, on: :member
  end
end
