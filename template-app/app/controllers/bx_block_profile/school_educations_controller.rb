module BxBlockProfile
	class SchoolEducationsController < ApplicationController
    before_action :validate_json_web_token, :authenticate_account, :intern?
    before_action :set_record, only: %i(show update)

	  def create
  		record = @current_user.build_school_education(school_education_params)
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
      if @record.update(school_education_params)
        return success_response(@record)
      else
        return error_response(@record)
      end
    end

	  private

    def school_education_params
      params.permit(:educational_status_id, :school_id, :school_name, :academic_level_id, :academic_achievement, :extracurricular_activity, :soft_skill, :interest, :hobby)
    end

	  def set_record
      @record = @current_user.school_education
      return render json: {message: "School education is not avaialble."},status: 404 unless @record
	  end

    def success_response(object, status = 200)
      res = SchoolEducationSerializer.new(object).serializable_hash
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
