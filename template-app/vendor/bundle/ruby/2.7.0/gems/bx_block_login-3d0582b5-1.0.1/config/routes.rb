BxBlockLogin::Engine.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs' if defined?(Rswag::Api)
  mount Rswag::Api::Engine => '/api-docs' if defined?(Rswag::Ui)

  resource :login, :only => [:create]
end
