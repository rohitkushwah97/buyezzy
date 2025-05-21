BxBlockShoppingCart::Engine.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Api)

  resources :orders, :only => [:index, :create, :show] do
    resources :order_items, :only => [:destroy]
  end

  resources :order_items, :only => [:create]
end
