BxBlockLocation::Engine.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Api)

  resources :vans, only: %i(show update) do
    collection do
      get :near_vans
      get :estimated_arrival_time
    end
  end
end
