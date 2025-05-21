module BxBlockRecommendation
  class InternshipFilters

    def filter_internship(internships,params)
      conditions = {}
      values = params.keys- ['match_type','duration_less_equal','duration_greater','salary_range']

      values.each  do |key|
       conditions[key] = params[key]
      end

      conditions[:monthly_salary] = params[:salary_range][:min]..params[:salary_range][:max] if params[:salary_range].present?

      conditions[:bx_block_recommendation_recommendations] = {match_type: params[:match_type]} if params[:match_type].present?

      duration_conditions = "EXTRACT(MONTH FROM age(end_date, start_date)) <= #{params[:duration_less_equal]}" if params[:duration_less_equal].present?

      duration_conditions =  "EXTRACT(MONTH FROM age(end_date, start_date)) > #{params[:duration_greater]}" if params[:duration_greater].present?

      internships.where(conditions).where(duration_conditions)
    end
  end
end
