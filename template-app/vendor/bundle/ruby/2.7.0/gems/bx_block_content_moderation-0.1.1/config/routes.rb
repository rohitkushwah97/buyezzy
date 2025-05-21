BxBlockContentModeration::Engine.routes.draw do
  resources :moderation, only: %i[index create]
end
