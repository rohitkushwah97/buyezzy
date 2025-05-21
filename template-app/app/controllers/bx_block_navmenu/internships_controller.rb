module BxBlockNavmenu
  class InternshipsController < ApplicationController
    before_action :validate_json_web_token, :authenticate_account
    before_action :business?, only: %i(create index show update destroy publish get_all_applicants update_applicant_status applicants_by_given_status closed_internship)
    before_action :intern?, only: %i(get_active_internships get_applied_internships get_status_wise_applied_internships get_internships_by_filter get_apply_internship withdraw terminate)
    before_action :set_internship, only: %i(show update destroy publish review_job_posting  withdraw terminate closed_internship)
    before_action :is_draft_internship?, only: %i(update destroy)
    before_action :check_publish_need, only: %i(publish)
    before_action :check_active, only: %i(create)
    before_action :get_internship, only: %i(get_apply_internship)
    before_action :check_deadline_date, only: %i[get_apply_internship]
    before_action :offers_pending, only: %i[withdraw terminate]
    before_action :pending_offers_by_business_users, only: %i[closed_internship]

    def index_internhsips
      internships =  InternshipFilters.new.filter_internship(@current_user,@current_user.internships,params,nil)
      success_response(internships.order(start_date: :asc))
    end

    def get_active_internships
      educational_statuses = [(@current_user.school_education || @current_user.university_education)&.educational_status&.id]
      active_internhsips = BxBlockNavmenu::Internship.joins(:business_user).active.where('educational_statuses @> ARRAY[?]::integer[] AND accounts.is_blacklisted=?',educational_statuses,false)
      internships = InternshipFilters.new.filter_internship(@current_user,active_internhsips,params,'active_internhsips')
      recommended_internships =Internship.joins(:recommendations).where(id:internships, bx_block_recommendation_recommendations: { intern_user_id: @current_user }).order('bx_block_recommendation_recommendations.match_type ASC').ids
      remain_internships = internships.where.not(id: recommended_internships).ids
      ids = recommended_internships + remain_internships
      case_statement = ids.map.with_index { |id, index| "WHEN #{id} THEN #{index}" }.join(' ')
      internships = Internship.where(id: ids).order(Arel.sql("CASE id #{case_statement} END"))
      internships = internships.visible if internships.present?
      @blocked_by_business_users = BxBlockBlockUsers::BlockUser.where(account_id: @current_user.id).pluck(:current_user_id)
      internships = internships.where.not(business_user_id: @blocked_by_business_users) if @blocked_by_business_users.any?
      blocked_users
      internships = internships.where.not(business_user_id: @blocked_user_ids) if @blocked_user_ids.present?
      paginate_response( internships,{id: @current_user.id}, serializer: BxBlockNavmenu::InternshipSerializer) 
    end

    def get_applied_internships
      internships = BxBlockNavmenu::Internship.joins(:account_internships)
      .where(accounts_bx_block_navmenu_internships: { account_id: @current_user.id, is_withdraw: false }).pluck(:id)

      @internships = Internship.joins(business_user: :company_detail).where(id:internships,accounts:{is_blacklisted: false})
      if params[:search].present?
        @internships = @internships.where("title ILIKE '%#{params[:search]}%' OR company_details.company_name ILIKE '%#{params[:search]}%'")
      end

      if params[:filter].present?
        @internships = Internship.joins(:recommendations).where(id:@internships) if params[:filter][:match_type].present?
        @internships = BxBlockRecommendation::InternshipFilters.new.filter_internship(@internships,params[:filter])
      end
      @blocked_by_business_users = BxBlockBlockUsers::BlockUser.where(account_id: @current_user.id).pluck(:current_user_id)
      @internships = @internships.where.not(business_user_id: @blocked_by_business_users) if @blocked_by_business_users.any?
      paginate_response(@internships.order(start_date: :asc),{id: @current_user},serializer: BxBlockNavmenu::InternshipSerializer)
    end

    def get_status_wise_applied_internships
      internship_ids = Internship.joins(:accounts).where(accounts: { id: @current_user.id }).ids

      @internships = Internship.joins(business_user: :company_detail)
                               .where(id: internship_ids, accounts: { is_blacklisted: false })

      if params[:search].present?
        search_term = "%#{params[:search]}%"
        @internships = @internships.where("title ILIKE :search OR company_details.company_name ILIKE :search", search: search_term)
      end

      if params[:filter].present?
        if params[:filter][:match_type].present?
          @internships = @internships.joins(:recommendations)
        end
        @internships = BxBlockRecommendation::InternshipFilters.new.filter_internship(@internships, params[:filter])
      end

      if params[:status].present?
        case params[:status]
        when "offered"
          @internships = @internships.joins(:account_internships)
                                     .where(account_internships: { account_id: @current_user.id, status: "offered" })
        when "rejected"
          @internships = @internships.joins(:account_internships)
                                     .where(account_internships: { account_id: @current_user.id, status: "rejected" })
        when "interview_requested"
          @internships = @internships.joins(:account_internships)
                                     .where(account_internships: { account_id: @current_user.id, status: "interview_requested" })
        else
            render json: { errors: ["Invalid status"] }, status: :bad_request and return
        end
      end
      @blocked_by_business_users = BxBlockBlockUsers::BlockUser.where(account_id: @current_user.id).pluck(:current_user_id)
      @internships = @internships.where.not(business_user_id: @blocked_by_business_users) if @blocked_by_business_users.any?
      paginate_response(
        @internships.order(start_date: :asc),
        { id: @current_user },
        serializer: BxBlockNavmenu::InternshipSerializer
      )
    end

    def withdraw
      application = BxBlockNavmenu::AccountInternship.find_by(account_id: @current_user.id, internship_id: @internship.id)
      if application.nil?
        render json: { message: "Application not found." }, status: :not_found
      elsif @internship.start_date <= Date.today
        render json: { message: 'Cannot withdraw after internship start date.' }, status: :unprocessable_entity
      else
        application.update(is_withdraw: true)
        render json: { is_withdraw: true, message: 'Internship withdrawn successfully.' }
      end
    end

    def terminate
      application = BxBlockNavmenu::AccountInternship.find_by(account_id: @current_user.id, internship_id: @internship.id)

      if application.nil?
        render json: { message: "Application not found." }, status: :not_found
      elsif @internship.start_date > Date.today
        render json: { message: "Cannot terminate before internship start date." }, status: :unprocessable_entity
      else
        application.update(is_terminate: true)
        render json: { is_terminate: true, message: "You have successfully terminate the internship." }, status: :ok
      end
    end

    def get_all_applicants
      internship = @current_user.internships.find_by(status:1)
      active_internship_present = internship.present? ? true : false
      if internship.present?
        @applicants = AccountBlock::InternUser.includes(:internships,:profile,:recommendations,:university_education,:school_education).joins(:account_internships).where(accounts_bx_block_navmenu_internships:{internship_id:internship, is_withdraw: false})
          .where(accounts:{is_blacklisted: false}).distinct
        blocked_users 
        @applicants = @applicants.where.not(id: @blocked_user_ids)
        @applicants = @applicants.where("full_name ILIKE ?", "%#{params[:search]}%") if params[:search].present?

      if params[:filter].present?

        @applicants = @applicants.where(bx_block_recommendation_recommendations:{internship_id: internship.id}) if params[:filter][:match_type].present?

        @applicants = BxBlockRecommendation::ApplicantFilter.new.filter_applicants(@applicants,params[:filter])

      end
        recommended_applicants = @applicants.where(bx_block_recommendation_recommendations:{internship_id: internship.id})
        applicants =  @applicants.where.not(id: recommended_applicants.ids ).ids
        recommended_applicants = recommended_applicants.order('bx_block_recommendation_recommendations.match_type ASC').map{|i| i.id}

        ids = recommended_applicants + applicants
        case_statement = ids.map.with_index { |id, index| "WHEN #{id} THEN #{index}" }.join(' ')

        @applicants = AccountBlock::InternUser.where(id: ids).order(Arel.sql("CASE id #{case_statement} END"))
        paginate_response(@applicants,{ internship: internship }, serializer: AccountBlock::InternUserSerializer )
      else
        render json: { data: [], active_internship_present: active_internship_present }, status: :not_found
      end
    end

    def applicants_by_given_status
      internship = @current_user.internships.find_by(status: :active)
      return render json: { message: "No active internship found" }, status: :not_found unless internship

      status = params[:status]
      unless BxBlockNavmenu::AccountInternship.statuses.key?(status)
        return render json: { error: "Invalid status" }, status: :unprocessable_entity
      end

      account_ids = BxBlockNavmenu::AccountInternship.where(
        internship_id: internship.id,
        status: status
      ).pluck(:account_id)

      @applicants = AccountBlock::InternUser.includes(:profile).where(id: account_ids)
      paginate_response(@applicants,{ internship: internship }, serializer: AccountBlock::InternUserSerializer )
    end

    def applied_internships
      account_internship_ids = BxBlockNavmenu::AccountInternship.where(account_id: @current_user.id).pluck(:internship_id)

      internships = BxBlockNavmenu::Internship.where(id: account_internship_ids)
      paginate_response(internships, { current_user_id: @current_user.id }, serializer: BxBlockNavmenu::ApplyedInternshipSerializer)
    end

    def update_applicant_status
      internship = @current_user.internships.find_by(id: params[:internship_id])
      return render json: { error: "Internship not found" }, status: :not_found unless internship

      applicant = AccountBlock::Account.find_by(id: params[:intern_id])
      return render json: { error: "Applicant not found" }, status: :not_found unless applicant

      relation = BxBlockNavmenu::AccountInternship.find_by(account_id: applicant.id, internship_id: internship.id)
      return render json: { error: "Application not found" }, status: :not_found unless relation

      if params[:status] == "rejected"
        offer = BxBlockSurveys::MakeOffer.find_by(intern_user_id: applicant.id, internship_id: internship.id)
        if offer.present? && %w[accepted rejected].include?(offer.offer_status)
          return render json: { error: "Cannot reject this applicant as they have already #{offer.offer_status} the offer." }, status: :unprocessable_entity
        end
      end

      if relation.update(status: params[:status])
        render json: { message: "Status updated successfully", data: relation }, status: :ok
      else
        render json: { error: relation.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def get_internships_by_filter
      internships = fetch_and_filter_internships
      success_response(internships)
    end

    def get_apply_internship
      begin
        application = BxBlockNavmenu::AccountInternship.find_or_initialize_by(account: @current_user, internship: @internship)

        if application.persisted? && !application.is_withdraw
          render json: { message: "Already applied." }, status: :unprocessable_entity
        else
          application.update(is_withdraw: false)
          create_new_applicant_notification(@internship)
          render json: { message: "Internship applied successfully." }, status: :ok
        end
      rescue => e
        render json: { error: "Something went wrong: #{e.message}" }, status: :internal_server_error
      end
    end

    def check_deadline_date
      if @internship.deadline_date.present? && @internship.deadline_date <= Date.today
        return render json: { message: 'The application deadline has passed. No new applications are accepted.' }
      end
    end

    def closed_internship
      @internship.update!(is_closed: true, status: "inactive")
      if @internship.present?
        render json: { is_closed: @internship.is_closed, message: 'Internship has been closed successfully.' }
      end
    end

    def create
      internship = @current_user.internships.new(internship_params)
      if internship.save
        success_response(internship)
      else
        error_response(internship)
      end
    end

    def show
      success_response(@internship)
    end

    def update
      if @internship.update(internship_params)
        success_response(@internship)
      else
        error_response(@internship)
      end
    end

    def destroy
      render json: { id: @internship.id, message: "Internship deleted." }, status: :ok if @internship.destroy
    end

    def publish
      return render json: { message: "Your internship listing is live." }, status: :ok if @internship.update(status: "active")
    end

    def fetch_and_filter_internships
      internships = BxBlockNavmenu::Internship.all
      internships = apply_internship_filters(internships)
      internships
    end

    def apply_internship_filters(internships)
      internships = internships.where(work_location_id: params[:work_location_id]) if params[:work_location_id].present?
      internships = internships.where(work_schedule_id: params[:work_schedule_id]) if params[:work_schedule_id].present?
      internships = internships.where('monthly_salary >= ?', params[:monthly_salary]) if params[:monthly_salary].present?
      internships = internships.where(country_id: params[:country_id]) if params[:country_id].present?
      internships = internships.where(city_id: params[:city_id]) if params[:city_id].present?
      internships = internships.where('start_date >= ?', params[:start_date]) if params[:start_date].present?
      internships
    end

    def review_job_posting
      res = ReviewJobPostingSerializer.new(@internship)
      render json: res, status: status
    end

  
    private

    def blocked_users
      @list_blocked_users = BxBlockBlockUsers::BlockUser.where('current_user_id = ?', @current_user.id)
      @blocked_user_ids = @list_blocked_users.pluck(:account_id)
    end

    def offers_pending
      offer_pending = @internship.make_offers.find_by(offer_status: "pending", internship_id: @internship.id)
      if offer_pending.present?
        return render json: { errors: "you cannot withdraw or terminate internship as offers is pending."}
      end
    end

    def pending_offers_by_business_users
      offer_pending = @internship.make_offers.where(offer_status: "pending")
      return render json: { errors: "your internship cannot closed as offers is pending."} if offer_pending.present?
    end

    def create_new_applicant_notification(internship)
      heading = "New Application"
      content = "A new application has been received for [#{@internship.title}]. Review it in your dashboard."
      navigates_to = "Applicant"
      business_user = internship.business_user
      if business_user&.notification_setting&.turn_off_new_application_alerts
        notification_creator = BxBlockNotifications::NotificationCreator.new(business_user, heading, content, navigates_to)
        notification_creator.call
      end
    end

    def internship_params
      params.require(:internship).permit(:start_date, :end_date, :deadline_date, :title, :description, :monthly_salary, :industry_id, :role_id, :work_location_id, :work_schedule_id, :country_id, :city_id, :status, educational_statuses: [])
    end

    def check_apply(internship)
      if @current_user.school_education.present?
        return render json: { message: "Please answer to additional questions. ", code: "complete generic question"  }, status: 401 unless check_generic_answers(internship)
      else
        return render json: { message: "To apply for this internship, you’ll need to add this role to your career interests and complete the quiz first.", code: @code }, status: 401 unless check_role_based_generic_answers(internship)
        return render json: { message: "Please answer to additional questions.", code: "complete generic question" }, status: 401 unless check_generic_answers(internship)
        return render json: { message: "Version of answers given by users is not same. You cannot apply for the job.", code: "version not match" }, status: 401 unless check_versions(internship)
      end
    end

    def is_draft_internship?
      return render json: { errors: "Internship has already been published." }, status: :unprocessable_entity unless @internship.status == "draft"
    end

    def check_publish_need
      return render json: { errors: "It looks like some mandatory items are missing" }, status: :unprocessable_entity if @internship.user_survey&.quiz_status == "pending"
      return render json: { errors: "Internship date has passed away"}, status: :unprocessable_entity if @internship.start_date <= Date.today
      return render json: { message: "Please Retake quiz to Publish." }, status: 401 if @internship.user_survey.retake
      return render json: { errors: "There cannot be more than one active internship." }, status: :unprocessable_entity if @current_user.internships.active.present?
    end

    def check_active
      return render json: { errors: "There can be only one active internship at-a-time. So Internship cannot be created." }, status: :unprocessable_entity unless @current_user.internships.active.blank?
    end

    def check_generic_answers(internship)
      internship.intern_user_generic_questions.ids&.sort == internship.intern_user_generic_answers.where(account_id: @current_user.id)&.pluck(:intern_user_generic_question_id)&.sort
    end

    def check_versions(internship)
      @current_user.user_surveys.find_by(role_id: internship.role.id)&.version_id == internship.user_survey&.version_id
    end

    def check_role_based_generic_answers(internship)
      if !@current_user.career_interests.find_by_role_id(internship.role.id).present?
        @code = "add role"
        false
      elsif !@current_user.user_surveys.find_by(role_id: internship.role.id, quiz_status: "completed").present?
        @code = "complete role based generic question"
        false
      else
        true
      end
    end

    def set_internship
      begin
        @internship = @current_user.internships.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        return item_not_found('internship', params[:id])
      end
    end

    def get_internship
      begin
        @internship = Internship.find(params[:id])
        check_apply(@internship) if @internship.present?
      rescue ActiveRecord::RecordNotFound
        return item_not_found('internship', params[:id])
      end
    end

    def paginate_response(objects,data,serializer:)
      active_internship_present = @current_user.internships.where(status: "active").any?
      if params[:per_page].to_i.zero?
        res = serializer.new(objects, params: data ).serializable_hash
        res[:active_internship_present] = active_internship_present
        return render json: res, status: :ok
      end

      page = params[:page].to_i == 0 ? 1 : params[:page].to_i
      per_page = params[:per_page].to_i

      objects = objects.page(page).per(per_page)

      res = serializer.new(objects, params: data).serializable_hash
      res[:active_internship_present] = active_internship_present

      res[:meta] = { pagination: {
        per_page: per_page,
        current_page: objects.current_page,
        next_page: objects.next_page,
        prev_page: objects.previous_page,
        total_pages: objects.total_pages,
        total_count: objects.total_entries
      } }
      render json: res, status: :ok
    end

    def success_response(objects, status = 200)
      res = BxBlockNavmenu::InternshipSerializer.new(objects,{ params: {id: @current_user.id} }).serializable_hash
      active_internship_present = @current_user.internships.where(status: "active").any?
      res[:active_internship_present] = active_internship_present
      render json: res, status: status
    end

    def error_response(object)
      render json: { errors: format_activerecord_errors(object.errors) }, status: :unprocessable_entity
    end

    def parse_json_array(json_data)
      JSON.parse(json_data) rescue []
    end  
  end
end