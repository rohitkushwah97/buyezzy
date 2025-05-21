class ChangePostsNameNullConstraint < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :name, true
  end
end
