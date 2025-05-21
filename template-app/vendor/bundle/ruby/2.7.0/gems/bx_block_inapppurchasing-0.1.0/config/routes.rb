BxBlockInapppurchasing::Engine.routes.draw do
  post 'store_transaction_details', to: 'subscriptions#store_transaction_details'
end
