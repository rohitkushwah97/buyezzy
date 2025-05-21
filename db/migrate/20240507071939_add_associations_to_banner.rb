class AddAssociationsToBanner < ActiveRecord::Migration[6.0]
  def change
    change_table :banners do |t|
      t.references :catalogue, foreign_key: true, null: true
      t.references :category, foreign_key: true, null: true
      t.references :sub_category, foreign_key: true, null: true
      t.references :deal, foreign_key: true, null: true
    end
  end
end
