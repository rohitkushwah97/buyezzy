class CreateReturnExchangeRequest < ActiveRecord::Migration[6.0]
	def change
		create_table :return_exchange_requests do |t|
			t.string :order_number
			t.string :request_type
			t.string :request_reason
			t.text :description
			t.references :order, null: false, foreign_key: { to_table: :shopping_cart_orders }
			t.index :order_number

			t.timestamps
		end
		add_reference :return_exchange_requests, :customer, foreign_key: { to_table: :accounts }
		add_column :return_exchange_requests, :status, :boolean, default: false
		add_column :return_exchange_requests, :custom_status, :string

		add_index :return_exchange_requests, :status
		add_index :return_exchange_requests, :custom_status

		create_join_table :return_exchange_requests, :order_items do |t|
			t.index [:return_exchange_request_id, :order_item_id], name: 'index_rer_on_rer_id_and_oi_id'
			t.index [:order_item_id, :return_exchange_request_id], name: 'index_rer_on_oi_id_and_rer_id'
		end
	end
end
