class AddInternCharacteristicIdToSubmissions < ActiveRecord::Migration[6.1]
 def up
    add_column :bx_block_surveys_submissions, :intern_characteristic_id, :bigint  
  end

  def down
    remove_column :bx_block_surveys_submissions, :intern_characteristic_id, :bigint
  end
end
