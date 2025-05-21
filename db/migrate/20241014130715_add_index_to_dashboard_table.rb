class AddIndexToDashboardTable < ActiveRecord::Migration[6.0]
  def change
  	add_index :trending_products, :slider
  	add_index :author_favorite_books, :status
  	add_index :banners, :description
  	add_index :banners, :button_text
  	add_index :banners, :button_link
  	add_index :most_popular_categories, :sequence_no
  	add_index :weekly_deals, :caption
  	add_index :weekly_deals, :discount_percent
  	add_index :weekly_deals, :url
  	add_index :weekly_homiee_deals, :start_time
  	add_index :weekly_homiee_deals, :end_time
  	add_index :weekly_homiee_deals, :status
  	add_index :social_platforms, :social_media
  	add_index :social_platforms, :social_media_url
  	add_index :sms_otps, :full_phone_number
  	add_index :sms_otps, :pin
  	add_index :seller_static_pages, :status
  	add_index :static_pages, :title
  	add_index :static_pages, :content
  	add_index :static_pages, :status
  	add_index :top_brands, :sequence_no

  end
end
