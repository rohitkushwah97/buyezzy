BxBlockShare::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)
  resources :share, only: [:index, :create] do
    collection do
      get :shared_with_me
    end
  end
  namespace :share do
    post :twitter
  end
end
