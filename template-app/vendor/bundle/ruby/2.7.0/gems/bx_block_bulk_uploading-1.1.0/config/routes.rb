# frozen_string_literal: true

BxBlockBulkUploading::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)
  resources :attachments, only: %i[index create show destroy]

  delete "/attachments/delete_attachment/:id/:file_id", to: "attachments#delete_attachment"
end
