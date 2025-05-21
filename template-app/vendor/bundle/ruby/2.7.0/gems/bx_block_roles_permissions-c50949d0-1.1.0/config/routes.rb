BxBlockRolesPermissions::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)
  get "accounts/list_users", to: "account_details#list_users"
  get 'accounts/get_assigned_role/:id', to: 'account_details#get_assigned_role'
  post 'accounts/assign_role', to: 'account_details#assign_role'
  post '/create', to: 'account_details#create'
end
