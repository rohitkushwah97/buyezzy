Rails.application.routes.draw do
	get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
	devise_for :admin_users, ActiveAdmin::Devise.config.merge(path: '', path_names: { sign_in: '' })
	ActiveAdmin.routes(self)
  root to: 'active_admin/devise/sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :bx_block_seo_setting do
  	resources :seo_settings
  end

  namespace :account_block do
    resources :suggestion_feedbacks
    resources :accounts, only: [:create,:update,:destroy,:show] do
      resources :seller_documents, except: [:destroy]
      post :document_verification_email, to: 'seller_documents#document_verification_email', on: :collection
      post 'resend_email', to: 'accounts#resend_email', on: :collection
      post 'upload_image', to: 'accounts#upload_image', on: :collection
      post 'send_otps', to: 'accounts/send_otps#create', on: :collection
      post 'sms_otp_confirmations', to: 'accounts/sms_confirmations#create', on: :collection
      get 'logged_user', to: 'accounts#logged_user', on: :collection
      resources :user_delivery_addresses, only: [:index,:create,:update,:destroy,:show]
    end
  end

  get 'account_activation', to: 'account_block/accounts#account_activation'
  post 'send_login_otp', to: 'bx_block_login/logins#send_login_otp'

  post '/forgot_password', to: 'bx_block_forgot_password/passwords#forgot_password'
  patch '/reset_password', to: 'bx_block_forgot_password/passwords#reset_password'
  post '/current_password', to: 'bx_block_forgot_password/passwords#current_password'

  namespace :bx_block_login do
  	resources :logins, only: [:create]
  end

  namespace :bx_block_categories do
    get 'list_sub_categories_from_catalogues', to: 'sub_categories#list_sub_categories_from_catalogues'
    get 'list_subcategories_by_category_ids', to: 'sub_categories#list_subcategories_by_category_ids'
    get 'list_minicategories_by_subcategory_ids', to: 'mini_categories#list_minicategories_by_subcategory_ids'
    get 'list_microcategories_by_minicategory_ids', to: 'micro_categories#list_microcategories_by_minicategory_ids'
    resources :categories, only: [:show,:index] do
      get 'search_micro_categories',to: 'categories#search_micro_categories', on: :collection
      resources :sub_categories, only: [:show,:index] do
        resources :mini_categories, only: [:show,:index] do
          resources :micro_categories, only: [:show,:index]
        end
      end
      resources :custom_fields, only: [:show,:index] do
        get 'show_custom_fields', to: 'custom_fields#show_custom_fields', on: :collection
      end
    end
  end

  # get 'search_sub_category', to: 'bx_block_categories/sub_categories#search_sub_category'
  get 'search_brands', to: 'bx_block_catalogue/brands#search_brands'
  get 'search_catalogues', to: 'bx_block_catalogue/catalogues#search_catalogues'

  get 'template_download', to: 'bx_block_catalogue/catalogues#template_download'

  post 'bulk_upload', to: 'bx_block_catalogue/catalogues#bulk_upload'


  namespace :bx_block_catalogue do

    resources :brands, only: [:create,:index,:show] do
      get 'list_sub_categories_from_brand', on: :collection
      get 'seller_brand_listing', on: :collection
      put 'update_seller_brands', on: :collection
      post 'create_seller_brand', on: :collection
      delete 'delete_seller_brand', on: :collection
      get 'list_brands_from_catalogues', to: 'brands#list_brands_from_catalogues', on: :collection
      get 'approved_brands_index', to: 'brands#approved_brands_index', on: :collection
      get 'restricted_brands_index', to: 'brands#restricted_brands_index', on: :collection
      get 'gated_brands_index', to: 'brands#gated_brands_index', on: :collection
      resources :restricted_brands, only: [:create,:index,:show,:update,:destroy]
      resources :gated_brands, only: [:create,:index,:show]
    end
    resources :warehouses, only: [:create,:index,:show] do 
      post 'create_seller_warehouse', on: :collection
      put 'update_seller_warehouse', on: :collection
      delete 'delete_seller_warehouse', on: :collection
      get 'seller_warehouse_listing', on: :collection
      resources :warehouse_catalogues, only: [:index, :show, :create, :update, :destroy]
    end
    resources :catalogues, only: [:create,:index,:show,:update] do
      get 'list_store_menu_products', on: :collection
      get 'sku_validate', to: 'catalogues#sku_validate', on: :collection
      post 'list_catalogue_by_category', to: 'catalogues#list_catalogue_by_category', on: :collection
      get 'search_catalogues_by_title_or_brand_name', to: 'catalogues#search_catalogues_by_title_or_brand_name', on: :collection
      get 'search_catalogues_by_brand', to: 'catalogues#search_catalogues_by_brand', on: :collection
      resources :product_contents, only: [:index, :create, :update]
      resources :product_variant_groups, only: [:index, :create, :update, :show, :destroy]
      resources :catalogue_contents, only: [:index, :create, :destroy] do
        patch 'update_catalogue_contents', to: 'catalogue_contents#update_catalogue_contents', on: :collection
        delete 'delete_catalogue_contents', to: 'catalogue_contents#delete_catalogue_contents', on: :collection
      end
      resources :barcodes, only: [:create,:show,:index, :update]
      resources :catalogue_offers, only: [:create,:show,:update]
    end

    get 'fetch_custom_field_filters', to: 'catalogue_contents#fetch_custom_field_filters'

    resources :catalogue_variants, only: [:index, :create, :update, :show, :destroy]

    resources :store_fronts, only: [:index] do
      get 'latest_product', on: :collection
      get 'popular_product', on: :collection
      get 'average_rating_for_seller', on: :collection
      get 'average_rating_for_product', on: :collection
      get 'ratings_percentage', on: :collection
      get 'latest_review_for_seller', on: :collection
      get 'list_reviews', on: :collection
      get 'ratings_percentage_for_product', on: :collection
      get 'latest_review_for_product', on: :collection
   end

    resources :deals, only: [:index,:show] do
      resources :deal_catalogues
    end

    resources :reviews do
      get :user_review_listing, on: :collection
      get :seller_happiness_indicator,on: :collection
      get :buyer_review_listing, on: :collection
      get :customer_rating_and_reviews, on: :collection
      resource :helpful_review, only: [:create, :destroy]
    end
    
    resources :parent_catalogues, only: [] do
      get 'search_parent_catalogues_by_title_or_brand_name', to: 'parent_catalogues#search_parent_catalogues_by_title_or_brand_name', on: :collection
    end
  end

  namespace :bx_block_termsandconditions do
    resources :terms_policies, only: [:show,:index]
    resources :seller_static_pages, only: [:show, :index] do
      delete 'delete_static_pages', to: '/seller_static_pages/delete_static_pages', on: :collection
    end
    resources :privacy_and_legal_policy, only: [:show, :index]
  end

  namespace :bx_block_support do
    resources :support_documents, only: [:show,:index] do
      delete 'delete_support_documents', to: '/support_documents/delete_support_documents', on: :collection
    end
    resources :supports, only: [:create]
    resources :static_pages, only: [:show,:index] do
      delete 'delete_static_pages', to: '/static_pages/delete_static_pages', on: :collection
    end
    resources :social_platforms, only: [:show,:index]
  end

  namespace :bx_block_store_management do
    resources :stores, only: [:index, :show, :create, :update, :destroy] do
      get "seller_store_listing", on:  :collection
      put 'update_seller_store', on: :member
      post 'create_seller_store', on: :collection
      delete 'delete_seller_store', on: :member
      get 'index_approved_stores', to: 'stores#index_approved_stores', on: :collection
      resources :store_menus, only: [:index, :show, :create, :update, :destroy] do
        get 'store_menus_list', to: 'store_menus#store_menus_list', on: :collection
      end
      resources :store_dashboard_sections, only: [:index, :show, :create, :update, :destroy] do
        resources :store_section_grids, only: [:index, :show, :create, :update, :destroy]
      end
    end
  end

  namespace :bx_block_dashboard do
    resources :most_popular_categories, only: [:index, :show]
    resources :header_categories, only: [:index, :show]
    resources :top_brands, only: [:index, :show]
    resources :trending_products, only: [:index, :show] do 
      post :list_trending_products, on: :collection
    end
    resources :weekly_homiee_deals, only: [:index, :show] do
      get 'latest_weekly_deal', on: :collection
    end
    resources :author_favorite_books, only: [:index, :show] do
      get 'latest_author_favorite', on: :collection
    end
    resources :banners, only: [] do
      collection do
        get 'header_slideshow', to: 'banners#header_slideshow_index'
        get 'header_single_images', to: 'banners#header_single_images_index'
        get 'middle_slideshow', to: 'banners#middle_slideshow_index'
        get 'middle_single_images', to: 'banners#middle_single_images_index'
        get 'footer_single_images', to: 'banners#footer_single_images_index'
        get 'top_banner', to: 'banners#top_banner'
      end
    end

    resources :global_searches, only: [] do
      collection do
        post :search
        get :brands_filter_lists
        get :categories_filter_lists
      end
    end
  end

  namespace :bx_block_custom_ads do
    resources :advertisements, only: [:index,:show]
  end

  namespace :bx_block_favourites do
    resources :favourites, only: [:index, :create, :destroy]
  end

  namespace :bx_block_shopping_cart do
    resources :return_exchange_requests
    resources :order_items, only: [:create, :destroy, :update, :index] do
      post :guest_user_order, on: :collection
    end
    resources :return_reason_details
    resources :orders, only: [:index, :show, :update, :destroy] do
      resources :shipped_order_details, only: [:create, :show, :update, :destroy]
      get :show_seller_order, on: :member
      post :apply_coupon_to_order, on: :member
      get :seller_orders, on: :collection
      delete 'destroy_all_orders', on: :collection
    end
    resources :telr_payments, only: [:create] do
      post :payment_failed_notification, on: :collection
      get :show_or_check, on: :collection
    end
  end
  namespace :bx_block_coupon_cg do
    resources :coupon_codes, only: [:index, :show]
    resources :subscribe_coupons, only: [:create, :update, :destroy, :index]
  end
  namespace :bx_block_order_management do
    resources :order_statues, only: [:index, :show]
    resources :delivery_requests, only: [:create, :update, :destroy, :index, :show]
    resources :stock_intakes, only: [:create, :update, :destroy, :index, :show]
    resources :anchanto_wms do
      match :event_grn_status_update_in_wms, on: :collection, via: [:get, :post]
      post :create_wms_product, on: :collection
      post :create_consignment_order, on: :collection
      # post :create_b2c_order, on: :collection
      # post :event_consignment_status_update_in_wms, on: :collection
      # post :event_b2c_shipment_status_update_in_wms, on: :collection
      match :create_b2c_order, to: :create_b2c_order, via: [:get, :post], on: :collection
      match :event_consignment_status_update_in_wms, to: :event_consignment_status_update_in_wms, via: [:get, :post], on: :collection
      match :event_b2c_shipment_status_update_in_wms, to: :event_b2c_shipment_status_update_in_wms, via: [:get, :post], on: :collection
      post :b2c_order_index, on: :collection
      post :b2c_order_show, on: :collection
    end
  end
  namespace :bx_block_contact_us do
    resources :contacts, only: [:create]
  end

  namespace :bx_block_invoicebilling do
    resources :invoice_billings, only: [] do
      collection do
        get :invoice_pdf
      end
    end
  end

  namespace :bx_block_salesreporting do
    resources :product_views, only: [:create] do
      get 'browsing_history', on: :collection
    end
    resources :reports do
      post 'sales_performance', on: :collection
    end
  end
end
