BxBlockWishlist::Engine.routes.draw do
  resources :wishlists, :only => [:index, :create, :destroy]
end
