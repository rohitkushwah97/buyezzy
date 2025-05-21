BxBlockPromoCodes::Engine.routes.draw do
  resources :promo_codes, only: :index
end
