BxBlockAddfriends::Engine.routes.draw do
  resources :connections
  get '/accept_connection', to: 'connections#accept_connection'
  put '/decline_connection', to: 'connections#decline_connection'
  get '/connection_requests', to: 'connections#connection_requests'
  get '/my_connections', to: 'connections#my_connections'
  get '/recommended_connections', to: 'connections#recommended_connections'
end
