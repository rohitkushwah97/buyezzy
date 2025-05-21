class AddParentCatalogueToCatalogue < ActiveRecord::Migration[6.0]
  def change
  	add_reference :catalogues, :parent_catalogue, foreign_key: { on_delete: :cascade }
  end
end
