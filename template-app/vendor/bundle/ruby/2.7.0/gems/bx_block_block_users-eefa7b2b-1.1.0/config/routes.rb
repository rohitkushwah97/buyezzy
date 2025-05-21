BxBlockBlockUsers::Engine.routes.draw do
  resources :block_users, :only => [:index, :show, :create, :destroy]
end
