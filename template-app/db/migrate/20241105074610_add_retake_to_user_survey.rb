class AddRetakeToUserSurvey < ActiveRecord::Migration[6.1]
  def change
    add_column :user_surveys, :retake, :boolean, default: false
  end
end
