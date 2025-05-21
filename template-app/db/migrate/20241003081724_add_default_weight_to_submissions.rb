class AddDefaultWeightToSubmissions < ActiveRecord::Migration[6.1]
  def up
    add_column :bx_block_surveys_submissions, :default_weight, :bigint
    add_column :intern_characteristic_importances, :intern_characteristic_id, :bigint
    add_column :intern_characteristic_importances, :value, :bigint
    remove_column :intern_characteristic_importances, :technical_skills, :integer
    remove_column :intern_characteristic_importances, :experience_and_projects, :integer
    remove_column :intern_characteristic_importances, :education_and_knowledge, :integer
    remove_column :intern_characteristic_importances, :soft_skills_and_attributes, :integer
  end

  def down
    remove_column :bx_block_surveys_submissions, :default_weight, :bigint
    remove_column :intern_characteristic_importances, :intern_characteristic_id, :bigint
    remove_column :intern_characteristic_importances, :value, :bigint
    add_column :intern_characteristic_importances, :technical_skills, :integer
    add_column :intern_characteristic_importances, :experience_and_projects, :integer
    add_column :intern_characteristic_importances, :education_and_knowledge, :integer
    add_column :intern_characteristic_importances, :soft_skills_and_attributes, :integer
  end
end
