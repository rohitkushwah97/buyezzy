# frozen_string_literal: true

BxBlockOrderManagement::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)
  resources :carts, only: [:create]
  resources :orders, only: %i[create show index destroy]
  resources :addresses, only: %i[index create show update destroy]
  put "orders/:order_id/cancel_order", to: "orders#cancel_order"
  put "orders/:order_id/update_order_status", to: "orders#update_order_status"
  get "orders", to: "orders#my_orders"
  put "orders/:order_id/add_address_to_order", to: "orders#add_address_to_order"
  put "orders/:order_id/update_payment", to: "orders#update_payment_source"
  post "orders/:order_id/apply_coupon", to: "orders#apply_coupon"

  post "/create_delivery_address", to: "admin#delivery_address_create"
  put "orders/:order_id/update_custom_label", to: "orders#update_custom_label"
  put "orders/:order_id/edit_custom_label", to: "orders#edit_custom_label"

  post "orders/:order_id/add_order_items", to: "orders#add_order_items"
  delete "orders/:order_id/remove_order_items", to: "orders#remove_order_items"
end
