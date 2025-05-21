class ChangeUserIdInProductViews < ActiveRecord::Migration[6.0]
  def change
  	change_column_null :product_views, :user_id, true
  end
end
