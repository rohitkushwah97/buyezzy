module BxBlockAdmin
	class ImportSurveyQuestionJob < BuilderBase::ApplicationJob
		queue_as :default

		def perform(csv_file_path)
			@errors = []
			@valid_roles = []
			CSV.parse(csv_file_path,headers: true) do |row|
				@role = BxBlockCategories::Role.find_by("LOWER(name) = ?", row["role_name"].downcase)
				if @role.present?
					@version = @role.survey.versions.new
					validate_question(row)
				else
					row['error'] = "Role is not present"
					@errors << row
				end
			end
			handle_errors_and_notifications(@errors)
		end

		private

		def validate_question(row)
			question_errors = []
			valid_question = []
			default_weight = []
			question_count = (row.size)/9
			(1..question_count).map do |num|
				next if row["Q#{num}_default_weight"].nil? && row["Q#{num}_intern_question"].nil? && row["Q#{num}_business_question"].nil?
				intern_characteristic = BxBlockSurveys::InternCharacteristic.find_by("LOWER(name) = ?", row["Q#{num}_intern_characteristic"].downcase) rescue nil

				options = (1..5).map { |i| { name: row["Q#{num}_option_#{i}"] } }
				question = { 
					business_question: row["Q#{num}_business_question"],
					intern_question: row["Q#{num}_intern_question"],
					default_weight: row["Q#{num}_default_weight"],
					survey_id: @role.survey.id,
					intern_characteristic_id: intern_characteristic&.id,
					options_attributes: options 
				}
				default_weight << row["Q#{num}_default_weight"].to_i
				validate_question = @version.questions.new(question)
				if validate_question.valid?
					valid_question << question
				else
					question_errors << "'Q_#{num}:- #{validate_question.errors.full_messages.join(', ')}'"
				end
			end
			
			question_errors << "The sum of default weight for all questions must be exactly 100." unless default_weight.sum == 100

			question_errors << "You can not add more than 20 questions for single role" if row["Q21_business_question"].present? || row["Q21_intern_question"].present? || row["Q21_default_weight"].present?

			if question_errors.blank?
				@role.survey.versions.create(questions_attributes: valid_question)
			else
				row['errors'] = question_errors.join(',')
				@errors << row
			end
		end

		def handle_errors_and_notifications(errors)
			if errors.any?
				error_csv_path = Rails.root.join('public', "errors_#{Time.now.to_i}.csv")
				CSV.open(error_csv_path, 'w') do |csv|
					csv << errors.first.headers
					errors.each { |row| csv << row }
				end

				notification = BxBlockNotifications::AdminNotification.create(
					message: 'CSV import failed for bulk upload questions. Please check the attached file for errors.'
					)
				notification.attachment.attach(io: File.open(error_csv_path), filename: 'errors.csv')
				File.delete(error_csv_path) if File.exist?(error_csv_path)
			else
				BxBlockNotifications::AdminNotification.create(
					message: 'Questions successfully imported!'
					)
			end
		end
	end
end