class RemoveUnwantedIndex < ActiveRecord::Migration[6.0]
	def change
		remove_index :bx_block_termsandconditions_privacy_nad_legal_policies, name: 'index_privacy_legal_policies_on_content', if_exists: true
		remove_index :admin_replies, column: :description, if_exists: true
		remove_index :catalogue_offers, column: :comments, if_exists: true
		remove_index :contacts, column: :description, if_exists: true
		remove_index :product_contents, column: :long_description, if_exists: true
		remove_index :return_exchange_requests, column: :description, if_exists: true
		remove_index :return_reason_details,column: :details, if_exists: true
		remove_index :review_and_ratings, column: :description, if_exists: true
		remove_index :banners, column: :description, if_exists: true
		remove_index :static_pages, column: :content, if_exists: true
	end
end
