class AddInternUserIdToChatbotInterviews < ActiveRecord::Migration[6.1]
  def change
    add_column :chatbot_interviews, :intern_user_id, :integer
  end
end
