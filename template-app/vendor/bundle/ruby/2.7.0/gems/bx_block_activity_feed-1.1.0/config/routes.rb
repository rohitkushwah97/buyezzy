# frozen_string_literal: true

BxBlockActivityFeed::Engine.routes.draw do
  resources :activity_feeds, only: %i[index show] do
    collection do
      get :account_feeds
    end
  end
  get "export_csv", to: "activity_feeds#export_csv"
end
