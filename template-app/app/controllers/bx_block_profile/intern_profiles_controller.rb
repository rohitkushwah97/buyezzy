module BxBlockProfile
  class InternProfilesController < ApplicationController
    before_action :validate_json_web_token, :authenticate_account
    before_action :set_intern_profile, only: :show
    
    def show
      intern = AccountBlock::InternUser.find(params[:id]) 
      contact_background = {
        full_name: "#{intern.first_name} #{intern.last_name}",
        email: intern.email,
        contact_number: intern&.phone_number,
        country: intern&.profile&.country,
        city: intern&.profile&.city
      }
      render json: {
        contact_background: contact_background,
        career_interests: intern.career_interests.map do |career_interest|
          {
            industry: career_interest.industry&.name,
            role: career_interest.role&.name
          }
        end,
        university: intern&.university_education,
        school: intern&.school_education
      }, status: :ok
    end

    def get_intern_user_generic_question
      intern = AccountBlock::InternUser.find(params[:id])
      if params[:internship_id].blank?
        return render json: { message: "Internship ID is required." }, status: :unprocessable_entity
      end

      internship = BxBlockNavmenu::Internship.find_by(id: params[:internship_id])

      if internship.nil?
        return render json: { message: "Internship not found." }, status: :not_found
      end
      answers_with_questions = intern.intern_user_generic_answers.joins(:intern_user_generic_question).where(internship_id: internship.id).map do |answer|
        {
          question: answer.intern_user_generic_question&.question,
          answer: answer.answer
        }
      end
      if answers_with_questions.blank?
        return render json: { message: "No questions found for this internship." }, status: :not_found
      end
      render json: answers_with_questions, status: :ok
    end

  private

    def set_intern_profile
      @intern_profile = AccountBlock::InternUser.find(params[:id])
    end
  end
end



