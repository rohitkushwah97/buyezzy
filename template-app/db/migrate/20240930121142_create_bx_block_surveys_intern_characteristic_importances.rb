class CreateBxBlockSurveysInternCharacteristicImportances < ActiveRecord::Migration[6.1]
  def change
    create_table :intern_characteristic_importances do |t|
      t.references :user_surveys,foreign_key: true, null: false
      t.integer :technical_skills  
      t.integer :experience_and_projects
      t.integer :education_and_knowledge
      t.integer :soft_skills_and_attributes
      t.timestamps
    end
  end
end