BxBlockStripeIntegration::Engine.routes.draw do
  if defined?(Rswag)
    mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag::Ui)
    mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag::Api)
  end

  mount StripeEvent::Engine, at: "/webhook_events"

  resources :payment_intents, only: :create
  resources :payment_methods, only: [:index, :create]

  resources :payments, only: [] do
    collection do
      post :confirm
    end
  end
end
