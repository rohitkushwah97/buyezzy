BxBlockDataImportExport::Engine.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Ui)
  mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag) && defined?(Rswag::Api)
  resources :export, only: [:index]
  get "export_csv", to: "export#export_csv"
end
