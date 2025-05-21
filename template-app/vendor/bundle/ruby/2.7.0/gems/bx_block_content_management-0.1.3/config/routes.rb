BxBlockContentManagement::Engine.routes.draw do
  resources :content_managements do
    collection do
      get 'approved'
      get 'user_type'
    end
  end
end
