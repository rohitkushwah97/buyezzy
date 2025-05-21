class AddIndexForMissingTable < ActiveRecord::Migration[6.0]
	def change
		add_index :accounts, :first_name
		add_index :accounts, :last_name
		add_index :accounts, :full_phone_number
		add_index :accounts, :phone_number
		add_index :accounts, :email
		add_index :accounts, :activated
		add_index :accounts, :user_type
		add_index :accounts, :last_visit_at
		add_index :accounts, :full_name
		add_index :accounts, :company_or_store_name
		add_index :accounts, :language
		add_index :accounts, :current_order

		add_index :activity_logs, :user_email

		add_index :admin_replies, :contact_id
		add_index :admin_replies, :description

		add_index :barcodes, :bar_code
		add_index :barcodes, :status

		add_index :brands, :brand_website
		add_index :brands, :brand_year

		add_index :bx_block_termsandconditions_privacy_nad_legal_policies, :title, name: 'index_privacy_legal_policies_on_title'
		add_index :bx_block_termsandconditions_privacy_nad_legal_policies, :content, name: 'index_privacy_legal_policies_on_content'
		add_index :bx_block_termsandconditions_privacy_nad_legal_policies, :status, name: 'index_privacy_legal_policies_on_status'

		add_index :catalogue_contents, :custom_field_name
		add_index :catalogue_contents, :value

		add_index :catalogue_offers, :price_info
		add_index :catalogue_offers, :sale_price
		add_index :catalogue_offers, :barcode_id
		add_index :catalogue_offers, :bar_code_info
		add_index :catalogue_offers, :sale_schedule_from
		add_index :catalogue_offers, :sale_schedule_to
		add_index :catalogue_offers, :warranty
		add_index :catalogue_offers, :comments
		add_index :catalogue_offers, :status

		add_index :contacts, :first_name
		add_index :contacts, :email
		add_index :contacts, :phone_number
		add_index :contacts, :description
		add_index :contacts, :contact_type
		add_index :contacts, :last_name
		add_index :contacts, :title

		add_index :custom_fields, :field_name
		add_index :custom_fields, :data_type
		add_index :custom_fields, :mandatory
		add_index :custom_fields, :fieldable_id

		add_index :deals, :start_date
		add_index :deals, :end_date

		add_index :feature_bullets, :field_name
		add_index :feature_bullets, :value

		add_index :group_attributes, :variant_attribute_id
		add_index :group_attributes, :attribute_option_id

		add_index :image_urls, :url

		add_index :product_contents, :brand_name
		add_index :product_contents, :long_description
		add_index :product_contents, :whats_in_the_package
		add_index :product_contents, :country_of_origin

		add_index :return_exchange_requests, :request_type
		add_index :return_exchange_requests, :request_reason
		add_index :return_exchange_requests, :description

		add_index :return_reason_details, :title
		add_index :return_reason_details, :details
		add_index :return_reason_details, :reason_type

		add_index :review_and_ratings, :title
		add_index :review_and_ratings, :description

		add_index :seller_documents, :document_type
		add_index :seller_documents, :document_name
		add_index :seller_documents, :vat_reason
		add_index :seller_documents, :iban
		add_index :seller_documents, :bank_address
		add_index :seller_documents, :name
		add_index :seller_documents, :bank_name
		add_index :seller_documents, :swift_code
		add_index :seller_documents, :account_no
		add_index :seller_documents, :approved
		add_index :seller_documents, :rejected

		add_index :shipped_order_details, :shipping_details

		add_index :shipping_details, :shipping_length
		add_index :shipping_details, :shipping_length_unit
		add_index :shipping_details, :shipping_height
		add_index :shipping_details, :shipping_height_unit
		add_index :shipping_details, :shipping_width
		add_index :shipping_details, :shipping_width_unit
		add_index :shipping_details, :shipping_weight
		add_index :shipping_details, :shipping_weight_unit

		add_index :shopping_cart_order_items, :discount_price

		add_index :size_and_capacities, :size
		add_index :size_and_capacities, :size_unit
		add_index :size_and_capacities, :capacity
		add_index :size_and_capacities, :capacity_unit
		add_index :size_and_capacities, :hs_code
		add_index :size_and_capacities, :prod_model_name
		add_index :size_and_capacities, :prod_model_number
		add_index :size_and_capacities, :number_of_pieces

		add_index :sms_otps, :activated
		add_index :sms_otps, :valid_until

		add_index :special_features, :field_name
		add_index :special_features, :value

		add_index :suggestion_feedbacks, :detail_type
		add_index :suggestion_feedbacks, :first_name
		add_index :suggestion_feedbacks, :last_name
		add_index :suggestion_feedbacks, :email
		add_index :suggestion_feedbacks, :account_id

		add_index :support_documents, :page_title

		add_index :supports, :first_name
		add_index :supports, :last_name
		add_index :supports, :email

		add_index :terms_policies, :page_title

		add_index :user_delivery_addresses, :is_default

		add_index :warehouses, :warehouse_type
		add_index :warehouses, :warehouse_address_1
		add_index :warehouses, :warehouse_address_2

	end
end
