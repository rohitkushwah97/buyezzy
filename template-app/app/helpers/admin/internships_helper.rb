module Admin
	module InternshipsHelper
		def get_education(applicant)
			if applicant.school_education.present?
				applicant.school_education&.school_name || applicant.school_education&.school&.name || "N/A"
			else
    		applicant.university_education&.university_name || applicant.university_education&.university&.name || "N/A"
    	end
		end

		def get_match(applicant, internship)
			applicant.recommendations.find_by(internship_id: internship.id)&.match_type || "N/A"
		end
	end
end