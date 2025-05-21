module BxBlockRecommendation
  class CalculateScore
    def calculate_score(user_survey,business_user_survey,threshold_percentage,user,type)
      compatibility_score = 0
      total_business_score = 0

      questions = user_survey.submissions.map{|sub| sub.question}

      questions.group_by(&:intern_characteristic_id).each do |question|
        admin_characteristic_weight = question[1].pluck("default_weight").sum
        business_characteristic_weight = business_user_survey&.intern_characteristic_importances&.find_by(intern_characteristic_id:question[0])&.value || 1

        question[1].each do |ques|
          submission = ques.submissions.find_by(account_id: user_survey.id)
          business_question_weight = (ques.default_weight*business_characteristic_weight).to_f/admin_characteristic_weight.to_f
          intern_option_value = submission.option_value_float
          question_score = business_question_weight * intern_option_value
          total_business_score += question_score
          business_option_value = business_user_survey.submissions.find_by(question_id:ques.id).option_value_float
          euclidean_distance = (Math.sqrt((intern_option_value - business_option_value)**2))*business_question_weight
          compatibility_score += euclidean_distance
        end
      end

      internship_id =  business_user_survey.internship_id
      role_id = business_user_survey.role_id
      CalculateRange.new.calculate_range(compatibility_score,total_business_score,threshold_percentage,user,internship_id,role_id,type)
    end
  end
end