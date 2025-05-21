BxBlockTermsAndConditions::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)

  resources :terms_and_conditions, only: [:index, :show, :create]
  post "/accept_and_reject", to: "terms_and_conditions#accept_and_reject"
  get "/latest_record", to: "terms_and_conditions#latest_record"
end
