module BxBlockAdmin
	class ImportInternJob < BuilderBase::ApplicationJob
		include CsvImportable
		sidekiq_options timeout: 900, retry: 3

		private

		def build_user_from_row(model_class, row)
			model_class.new(
				email: row['email'], 
				password: row['password'], 
				date_of_birth: row['date_of_birth']
			)
		end
	end
end