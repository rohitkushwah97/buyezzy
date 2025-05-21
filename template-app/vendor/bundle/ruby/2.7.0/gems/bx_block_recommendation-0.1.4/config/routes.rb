BxBlockRecommendation::Engine.routes.draw do
    get 'most_sold_products', to: 'catalogue_recommends#most_sold_products'
    get 'recent_sold_product', to: 'catalogue_recommends#recent_sold_products'
    get 'specific_category', to: 'catalogue_recommends#specific_category'
    get 'user_wishlist', to: 'catalogue_recommends#user_wishlist'
    get 'similar_category_products', to: 'catalogue_recommends#similar_category_products'
    get 'similar_color_products', to: 'catalogue_recommends#similar_color_products'
    get 'user_previous_order_product', to: 'catalogue_recommends#user_previous_order_products'
    get 'similar_size_products', to: 'catalogue_recommends#similar_size_products'
    get 'default_recommendation_setting', to: 'catalogue_recommends#default_recommendation_setting'
    get 'custom_recommendation_setting', to: 'catalogue_recommends#custom_recommendation_setting'
end
