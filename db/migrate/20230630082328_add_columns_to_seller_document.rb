class AddColumnsToSellerDocument < ActiveRecord::Migration[6.0]
  def change
    add_column :seller_documents, :rejected, :boolean
    add_column :seller_documents, :reason_for_rejection, :string
  end
end
