class AddColumnQuestionInAppliedJobs < ActiveRecord::Migration[6.0]
  def change
  	add_column :applied_jobs ,:question , :string, array: true, default: []
  end
end
