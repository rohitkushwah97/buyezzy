module BxBlockProfile
	class UniversityEducationsController < ApplicationController
    before_action :validate_json_web_token, :authenticate_account, :intern?
    before_action :set_record, only: %i(show update)

	  def create
  		record = @current_user.build_university_education(university_education_params)
	    if record.save
	      return success_response(record, :created)
	    else
	      return error_response(record)
	    end
	  end

    def show
      return success_response(@record)
    end

    def update
      if @record.update(university_education_params)
        return success_response(@record)
      else
        return error_response(@record)
      end
    end

	  private

    def university_education_params
      params.permit(:educational_status_id, :university_id, :university_name, :specialisation, :graduation_year)
    end

	  def set_record
      @record = @current_user.university_education
      return render json: {message: "Unversity education is not avaialble."},status: 404 unless @record
	  end

    def success_response(object, status = 200)
      res = UniversityEducationSerializer.new(object).serializable_hash
      render json: res, status: status
    end

    def error_response(object)
      render json: {
        errors: format_activerecord_errors(object.errors)
      },
      status: :unprocessable_entity
    end
	end
end
