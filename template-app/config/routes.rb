require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :account_block do
    post 'resend_email', action: :resend_email, controller: 'accounts'
    delete 'delete_user', action: :delete_user, controller: 'accounts'
    get 'account_deletion', to: 'accounts#account_deletion', action: :account_deletion, controller: 'accounts'
    get 'details/:id', to: 'accounts#details', as: :account_details
    get '/display_business/:business_user_id', action: :display_business, as: :display_business

    resources :intern_users do
      collection do 
        get '/display_internship/:internship_id', action: :display_internship, as: :display_internship
        get '/display_business/:business_user_id', action: :display_business, as: :display_business
      end
      member do
        get '/career_interests', action: :get_career_intrest, as: :career_interests  
        get '/education_details', action: :get_education_details, as: :education_details 
        get 'get_intern_user_internships'
      end
    end
    resource :business_users do
      collection do
        get 'list', action: :index
        get 'list_cities', action: :list_cities
      end
    end
  end

  namespace :bx_block_order_management do
    resources :admin do
      get :get_roles, on: :collection
      get :get_industries, on: :collection
      get :get_work_locations, on: :collection
      get :get_work_schedules, on: :collection
      get :get_countries,on: :collection
      get :get_cities, on: :collection
      get :type_of_interns, on: :collection
    end
  end

  namespace :bx_block_notifsettings do
    resource :notification_settings, only: %i(show update)
  end

  namespace :account_block do
    resources :countries, only: %i(index show)
    resources :deeplinks do
      get :dl, on: :collection
      get :forgot_password, on: :collection
      get :contactus_linking, on: :collection
      get :email_preferences_linking, on: :collection
    end
  end

  namespace :bx_block_surveys do
    get 'remove_interncharacteristics', to: 'surveys#remove_interncharacteristics'
    resources :questions, only: %i(index show)
    resources :business_user_generic_answers, only: [:index, :create]
    resources :business_user_generic_questions, only: [:index] do
      collection do
        get :business_user_generic_questions
      end
    end

    resources :submissions, only: %i(create index) do
      collection do
        get :questions_and_answer
        post :create_intern_characteristic_importances
      end
    end

    resources :contact_interns, only: %i(create index update) do
      post :unlock_candidates, on: :collection
      get :get_contacted_applications, on: :collection
    end

    resources :intern_user_generic_questions, only: [:create,:index] do
      collection do
        patch 'update', to: 'intern_user_generic_questions#update'
        put 'update', to: 'intern_user_generic_questions#update'
        get :dummy_trigger_exception
        get :intern_user_generic_questions
        get 'get_applicants/:id', to: 'intern_user_generic_questions#get_applicants', as: 'get_applicants'
      end
    end

    resources :intern_user_generic_answers, only: [:create] do
      get :generic_answers_and_questions, on: :collection
    end
  end

  
  namespace :bx_block_profile do
    resources :validations, only: %i(index)
    resource :university_educations, only: %i(create update show destroy)
    resource :school_educations, only: %i(create update show destroy)
    resources :educational_statuses, only: %i(index) do
      get :universities, on: :member
      get :schools, on: :member
      get :get_user_education, on: :collection
      get :get_navigation_detail, on: :collection
    end
    resources :academic_levels, only: %i(index)
    resources :career_interests, except: %i(update) do
      get :get_other_career_interests, on: :collection
    end
    resources :intern_profiles, only: %i(show index)
    get 'intern_profiles/:id/get_intern_user_generic_question', to: 'intern_profiles#get_intern_user_generic_question', as: :get_intern_user_generic_question
    resources :report, only: %i(index create show destroy)
  end

  namespace :bx_block_login do
    resources :logins, only: %i(create)
    post 'logout', to: 'logins#logout'
  end
  
  namespace :bx_block_terms_and_conditions do
    resources :terms_and_conditions, only: %i(index)
    get 'policies', action: :get_privacy_policies, controller: 'terms_and_conditions'
  end

  namespace :bx_block_help_centre do
    resources :contact_us, only: [:create]
    resources :issue_types, only: [:index]
  end

  namespace :bx_block_navmenu do
    resources :internships do
      put :publish, on: :member
      get :get_apply_internship, on: :member
      post :index_internhsips, on: :collection
      post :get_active_internships, on: :collection
      post :get_all_applicants, on: :collection
      post :get_applied_internships, on: :collection
      get :get_status_wise_applied_internships, on: :collection
      put :update_applicant_status, on: :collection
      get :applicants_by_given_status, on: :collection
      get :applied_internships, on: :collection
      get :get_internships_by_filter, on: :collection
      get :review_job_posting, on: :collection
      put :withdraw, on: :member
      put :terminate, on: :member
      put :closed_internship, on: :member
    end
  end 

  namespace :bx_block_forgot_password do
    post 'reset_password', to: 'reset_passwords#create'
    patch 'reset_password', to: 'reset_passwords#update'
    get 'deep_link_redirect', to: 'static#deep_link_redirect'
    get 'contact_us_deeplinking', to: 'static#contact_us_deeplinking'
    get 'email_preferences_deeplinking', to: 'static#email_preferences_deeplinking'
  end

  namespace :bx_block_profile do 
    resource :company_details do
      get :intern_user_profile_details, on: :collection
    end
  end

  namespace :bx_block_recommendation do 
    resources :internship_recommendations, only: [:index] do
      post :get_internsips_recommendation, on: :collection
      post :get_recommended_applicants, on: :collection
      delete :destory_recommendations, on: :collection
    end
  end
  
  namespace :bx_block_help_centre do
    resources :faq, only: [:index, :show, :create, :update, :destroy, :new] do
      collection do
        get 'business_faq', to: 'faq#business_faq'
        get 'intern_faq', to: 'faq#intern_faq'
        get 'general_faq', to: 'faq#general_faq'
      end
    end
  end
  namespace :bx_block_notifications  do
    resources :notifications do
      collection do
        get 'unread_notifications', to: 'notifications#unread_notifications'
        put 'mark_all_read', to: 'notifications#mark_all_read'
        put 'mark_as_read/:id', to: 'notifications#mark_as_read'  
      end
    end
  end

  namespace :bx_block_posts  do
    resources :posts do
      get :users_all_posts, on: :collection
      get :activity_feed_posts, on: :collection
    end
  end

  namespace :bx_block_favourites  do
    resources :follows do
      get :current_user_followings, on: :collection
      get :current_user_followers, on: :collection
      delete :unfollow, on: :collection
      delete :remove_follower_from_followers, on: :collection
    end
  end

  namespace :bx_block_like do
    resources :likes, only: :create do
      delete :destroy, on: :collection
      get :get_likes_on_a_post, on: :collection
    end
  end

  namespace :bx_block_comments do
    resources :comments, only: :create do
      delete :destroy,on: :collection
      put :update,on: :collection
      get :get_comments_on_a_post, on: :collection
    end
  end

  namespace :bx_block_reviews do
    resources :reviews do
      get :show_feedback, on: :collection
    end
  end

  namespace :bx_block_chatgpt3 do
    resources :chatbots, only: [] do
      collection do
        post :start_interview
        post :submit_response
      end
    end
  end

  namespace :bx_block_surveys do
    resources :make_offers do
      collection do
        put :accept
        put :reject
      end
    end
  end

  namespace :bx_block_block_users do
    resources :block_users
  end

  namespace :bx_block_request_management do
    resources :request_interviews, only: [:create] do
      collection do
        put :accept_request_interviews
        put :reject_request_interviews
      end
    end
  end

end
