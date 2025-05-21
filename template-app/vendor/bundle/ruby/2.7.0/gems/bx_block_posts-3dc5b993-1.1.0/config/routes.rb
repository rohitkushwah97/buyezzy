BxBlockPosts::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)
  resources :posts, only: [:create, :show, :index, :update, :destroy] do
    collection do
      get :search
    end
  end
end
