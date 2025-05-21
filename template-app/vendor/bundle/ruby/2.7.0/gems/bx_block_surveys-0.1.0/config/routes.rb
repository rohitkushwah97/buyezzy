BxBlockSurveys::Engine.routes.draw do
  resources :surveys, only: %i[index show]
  resources :questions, only: %i[index show]
  resources :submissions, only: %i[index create]
  get 'show_submission', to: 'submissions#show_submission'
  get 'survey_result_download', to: 'surveys#download_excel'
end
