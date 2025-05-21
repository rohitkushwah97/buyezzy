BxBlockAnalytics::Engine.routes.draw do
  if defined?(Rswag)
    mount Rswag::Ui::Engine => "/api-docs" if defined?(Rswag::Ui)
    mount Rswag::Api::Engine => "/api-docs" if defined?(Rswag::Api)
  end

  resources :analytics_events, only: :create
end
