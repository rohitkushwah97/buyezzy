class AddTimestampsAndRemovePlanIdToAdvertisements < ActiveRecord::Migration[6.0]
	def change
		remove_column :advertisements, :plan_id, :integer
		add_timestamps :advertisements, default: -> { 'CURRENT_TIMESTAMP' }
	end
end
