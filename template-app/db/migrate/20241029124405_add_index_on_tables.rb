class AddIndexOnTables < ActiveRecord::Migration[6.1]
   def up
    add_index :profiles, :country_id
    add_index :profiles, :city_id

    add_index :school_educations, :school_id
    add_index :university_educations, :university_id
  end

  def down
    remove_index :profiles, :country_id
    remove_index :profiles, :city_id

    remove_index :school_educations, :school_id
    remove_index :university_educations, :university_id
  end
end
