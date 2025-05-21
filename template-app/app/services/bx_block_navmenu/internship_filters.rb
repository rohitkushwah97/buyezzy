module BxBlockNavmenu
  class InternshipFilters

    def filter_internship(user,internships,params,type)
      conds = {}
      @params = params
      conds[:work_location_id] = params[:work_location_id] if params[:work_location_id].present?      
      conds[:work_schedule_id] = params[:work_schedule_id] if params[:work_schedule_id].present?
      conds[:country_id] = params[:country_id] if params[:country_id].present?
      conds[:city_id] = params[:city_id] if params[:city_id].present?
      conds[:start_date] = params[:start_date] if params[:start_date].present?
      conds[:monthly_salary] = params[:min_monthly_salary]..params[:max_monthly_salary] if params[:min_monthly_salary].present? && params[:max_monthly_salary].present?
      conds[:role_id] = params[:your_role_ids] if params[:your_role_ids].present?
      conds[:role_id] = params[:other_role_ids] if params[:other_role_ids].present?
      internships = internships.joins(business_user: :company_detail).where("bx_block_navmenu_internships.title ILIKE ? OR company_details.company_name ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?

      internships = internships.where(conds)

      internships = internships.joins(:recommendations).where(bx_block_recommendation_recommendations:{match_type: params[:match_type],intern_user_id: user.id}) if params[:match_type].present?

      internships = filter_by_duration(internships) if params[:duration].present?
      internships = match_versions(internships,user) if type == "active_internhsips" && user&.university_education.present?
      internships
    end

    private

    def match_versions(internships,user)
      user_survey = user.user_surveys
      without_submission_role_ids = user_survey.where(version_id: nil).pluck(:role_id)
      role_ids = user_survey.pluck(:role_id)
      version_id = user_survey.pluck(:version_id)

      int1 = internships.where(role_id: without_submission_role_ids)
      int2 = internships.where.not(role_id: role_ids)
      int3 = internships.joins(:user_survey).where(user_surveys:{version_id: version_id})
      internships = int1 + int2 +int3
      Internship.where(id: internships).distinct
    end

    def filter_by_duration(internships)
      case @params[:duration]
      when "less than equals to one month"
        internships.where('duration <= 30')
      when "less than equals to three months"
        internships.where('duration <= 90')
      when "less than equals to six months"
        internships.where('duration <= 180')
      else
        internships.where('duration > 180')
      end
    end
  end
end
