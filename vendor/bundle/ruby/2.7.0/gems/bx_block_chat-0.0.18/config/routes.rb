BxBlockChat::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)
  namespace :chats do
    post :add_user, to: "add_user#add"
    get :users, to: "add_user#index"
    post :leave, to: "leave_chat#leave"
  end
  resources :chats, only: [:index, :show, :create, :update] do
    resources :messages, only: [:create]
    collection do
      get :search
      get :search_messages
      get :history
      put :read_messages
    end
  end

  if defined?(ActionCable)
    mount ActionCable.server => "/cable"
  end
end
