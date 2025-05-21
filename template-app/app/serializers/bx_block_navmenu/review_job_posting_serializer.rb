module BxBlockNavmenu
  class ReviewJobPostingSerializer < BuilderBase::BaseSerializer

    attribute :internship_details do |object|
      @completed = "Completed"
      @pending = "Pending"
      @completed
    end

    attribute :industry_quiz do |object|
      object.user_survey.quiz_status.titleize rescue nil
    end

    attribute :intern_characteristic do |object|
      @user_survey = object.user_survey
      intern_characteristic = @user_survey&.intern_characteristic_importances.present?
      intern_characteristic ?  @completed : @pending
      
    end

    attribute :extra_questions do |object|
      extra_questions = object.intern_user_generic_questions.present?
      extra_questions ?  @completed : @pending
      
    end

    attribute :job_description do |object|
      job_description = BxBlockSurveys::BusinessUserGenericQuestion.count == object.business_user_generic_answers.count
      job_description ?  @completed : @pending
    end

    attribute :retake do |object|
      @user_survey.retake if object.status == "draft"
    end

    attribute :role_id do |object|
     object.role_id
    end
  end
end