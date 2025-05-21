module AccountBlock
  class InternUsersController < AccountBlock::ApplicationController
    before_action :set_intern_user, only: %i(show update destroy)
    skip_before_action :validate_json_web_token, :authenticate_account ,only: %i(create get_education_details get_career_intrest display_business, get_generic_answers_and_questions, get_intern_user_internships)

    def create
      intern_user = Account.find_by(email: params[:data][:attributes][:email]&.downcase)
      return render json: {message: "This email address is already taken. Please try another."} if intern_user.present? 
      intern_user = InternUser.new(jsonapi_deserialize(params))
      if intern_user.save
        AccountActivationMailer.with(account: intern_user).activation_email.deliver_now!
        return success_response(intern_user, :created)
      else
        return error_response(intern_user)
      end
    end

    def show
      return success_response(@intern_user)
    end

    def update
      photo = params[:profile_attributes]&.dig(:photo)
      
      if photo && photo.size > 5.megabytes
        render json: { errors: 'Photo is too large. Maximum size allowed is 5 MB.' }, status: :unprocessable_entity
        return
      end

      allowed_formats = ['image/jpeg', 'image/jpg', 'image/svg+xml', 'image/png', 'image.heic']
      if photo && !allowed_formats.include?(photo.content_type)
        render json: { errors: 'Invalid image format. Only JPEG, JPG, SVG, PNG, and HEIC are allowed.' }, status: :unprocessable_entity
        return
      end

      if @intern_user.update(input_params)
        generate_profile_thumbnail(@intern_user.profile, photo) if photo.present?
        success_response(@intern_user)
      else
        error_response(@intern_user)
      end
    end

    def index 
      success_response(InternUser.all)
    end

    def destroy
      return render json: {id: @intern_user.id, message: "Inter User deleted."},status: 200 if @intern_user.destroy
    end

    def display_internship
      internship = BxBlockNavmenu::Internship.find_by(id: params[:internship_id])
      if internship.present?
        render json: BxBlockNavmenu::InternshipSerializer.new(internship,params: {id:@current_user.id}).serializable_hash, status: :ok
      else
        render json: { meta: { message: 'Record not found.' } }, status: :not_found
      end
    end

    def display_business
      business_user = AccountBlock::BusinessUser .find_by(id: params[:business_user_id])
      if business_user.present?
        company_detail = BxBlockProfile::CompanyDetail.find_by(id: business_user.company_detail)
        render json: BxBlockProfile::CompanyDetailSerializer.new(company_detail).serializable_hash
      else
        render json: { meta: { message: "Record not found" } }, status: :not_found
      end
    end

    def get_education_details
      @intern_user = AccountBlock::InternUser.find_by(id: params[:id])
      school = @intern_user&.school_education
      university = @intern_user&.university_education
    end

    def get_career_intrest
      @intern_user = AccountBlock::InternUser.find_by(id: params[:id])
      career_interest = @intern_user&.career_interests
    end

    def get_intern_user_internships
      @intern_user = AccountBlock::InternUser.find_by(id: params[:id])
      @internships_with_answers = []

      if @intern_user.present?
        @intern_user.internships.each do |internship|
          answers_and_questions = BxBlockSurveys::InternUserGenericAnswer.includes(:intern_user_generic_question)
                                                         .where(account_id: @intern_user.id, internship_id: internship.id)

          if answers_and_questions.present?
            completed = answers_and_questions.last.updated_at.strftime('%d/%m/%y')
            # Directly push the internship and its answers without serialization
            @internships_with_answers << { internship: internship, answers: answers_and_questions, completed: completed }
          else
            @internships_with_answers << { internship: internship, answers: [], completed: nil }
          end
        end
      end
    end

    private

    def generate_profile_thumbnail(profile, file)
      require 'image_processing/mini_magick'
      thumbnail_tempfile = Tempfile.new(['thumb', '.jpg'], binmode: true)

      begin
        ImageProcessing::MiniMagick
          .source(file.tempfile)
          .resize_to_limit(300, 300)
          .call(destination: thumbnail_tempfile.path)

        thumbnail_tempfile.rewind

        profile.photo_thumbnail.attach(
          io: thumbnail_tempfile,
          filename: "thumb_#{file.original_filename}.jpg",
          content_type: 'image/jpeg'
        )
      ensure
        thumbnail_tempfile.close!
        thumbnail_tempfile.unlink
      end
    end

    def input_params
      params.permit(
        :full_name,
        :email,
        :date_of_birth,
        :password,
        :full_phone_number,
        :country_flag,
        profile_attributes: [:id, :country_id, :city_id, :photo]
      )
    end

    def set_intern_user
      begin
        @intern_user = InternUser.find(params[:id])
        return render json: { message: "You are not authorise to perform this action." }, status: 401 unless @current_user == @intern_user
      rescue ActiveRecord::RecordNotFound
        return item_not_found('intern_user', @intern_user.id)
      end
    end

    def success_response(intern_user, status = 200)
      res = InternUserSerializer.new(intern_user).serializable_hash
      render json: res, status: status
    end

    def error_response(intern_user)
      render json: {
        errors: format_activerecord_errors(intern_user.errors)
      },
      status: :unprocessable_entity
    end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port } }
    end
  end
end