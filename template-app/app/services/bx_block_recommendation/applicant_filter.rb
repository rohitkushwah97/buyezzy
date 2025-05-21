module BxBlockRecommendation
  class ApplicantFilter
    def filter_applicants(applicants,params)
      conditions = {}
      conditions[:profile] = {country_id:  params[:country_id]} if params[:country_id].present?

      city = {city_id:  params[:city_id]}

      conditions[:profile] = conditions[:profile].present? ?  conditions[:profile].merge(city) : conditions[:profile] = city if params[:city_id].present?

      conditions[:bx_block_recommendation_recommendations] = {match_type: params[:match_type]} if params[:match_type].present?

      education_conditions = "school_educations.school_id IN (#{params[:school_education_id].join(',')})" if params[:school_education_id].present?

      education_conditions = [education_conditions,"university_educations.university_id IN (#{params[:university_education_id].join(',')})"].reject(&:blank?).join(' OR ') if params[:university_education_id].present?

      applicants.where(conditions).where(education_conditions)
    end
  end
end