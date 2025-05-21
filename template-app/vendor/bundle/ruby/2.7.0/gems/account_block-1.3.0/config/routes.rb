AccountBlock::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)

  resources :accounts, only: [:create, :index] do
    collection do
      get :search
      get :logged_user
      put :change_email_address
      put :change_phone_number
    end
  end

  namespace :accounts do
    resource :country_code_and_flag, only: [:show]
    resource :email_confirmation, only: [:show]
    resource :sms_confirmation, only: [:create]
    resource :send_otp, only: [:create]
  end
end
