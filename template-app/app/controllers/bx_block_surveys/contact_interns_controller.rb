module BxBlockSurveys
	class ContactInternsController < ApplicationController
		include BuilderJsonWebToken::JsonWebTokenValidation
		before_action :validate_json_web_token,:authenticate_account,:business?
		before_action :business?, except: [:get_contacted_applications]
		before_action :intern?, only: [:get_contacted_applications]
		before_action :find_internship, except: [:update,:get_contacted_applications]
		before_action :applied_check?, :check_contact_intern_count?, only: [:create]
		before_action :find_contact_intern, only: [:update]
		before_action :check_unlock_intern_count?, only: [:unlock_candidates]
		before_action :all_rejected?, only: [:index, :unlock_candidates]

		def index
			if params[:search].present?
				@contact_interns = @contact_interns.where("accounts.full_name ILIKE ? ","%#{params[:search]}%")
			end
			if @contact_interns.present?
				res = ContactInternSerializer.new(@contact_interns,params:{internship: @internship}).serializable_hash
				render json: res.merge!({unlock_candidates: @unlock_candidates}), status:200
			else
				render json: {data: []}, status: 404
			end
		end

		def create
			begin
				@internship.contact_interns.create!(intern_user_id:params[:intern_user_id])
				render json: {message: "Contacted successfully", contacted: true}, status:201
			rescue StandardError => e
				render json: {error: "You can not contact one intern more then one"},status: 422
			end
		end

		def update
			begin
		    @contact_intern.update!(decision: params[:decision].to_i)
		    @contact_intern.reload
		    if @contact_intern.decision == 1 || @contact_intern.decision == "offer_made"
		      intern_user = AccountBlock::InternUser.find(@contact_intern.intern_user_id)
		      internship = BxBlockNavmenu::Internship.find(@contact_intern.internship_id)
		      heading = "You're Selected!"
		      content = "Congratulations! You’ve been Selected for [#{internship.title}].Stay tuned for further updates from the client."
		      business_user = internship.business_user
		      notification_creator = BxBlockNotifications::NotificationCreator.new(intern_user, heading, content)
		      notification_creator.call
		    end

		    render json: { message: "updated successfully" }, status: :ok
		  rescue StandardError => e
		    render json: { error: e.message }, status: :unprocessable_entity
		  end
		end

		def unlock_candidates
			recommended_users_ids = @internship.recommended_users.pluck("id")
			contact_interns_ids = @contact_interns.pluck("intern_user_id")
			user_ids = recommended_users_ids - contact_interns_ids
			recommended_users = @internship.accounts.where(id:user_ids).order("RANDOM()").limit(3).ids

			if recommended_users.size < 3
				remaining_count = 3 - recommended_users.size
				excepted_ids = (recommended_users_ids + contact_interns_ids).uniq
				user_records_ids =  @internship.accounts.where.not(id:excepted_ids).order("RANDOM()").limit(remaining_count).ids  
				combined_records = recommended_users + user_records_ids

				return render json: {error: "No candidates are available to contact."}, status: 422 unless combined_records.present?
				create_contact_intern(combined_records)

			else
				create_contact_intern(recommended_users)
			end
		end

		def get_contacted_applications
			internships = BxBlockNavmenu::Internship.joins(:contact_interns).where(contact_interns: {intern_user_id: @current_user,decision:1})
			res = BxBlockNavmenu::InternshipSerializer.new(internships, params: {id: @current_user.id})
			render json: res, status: 200
		end

		private

		def create_contact_intern(ids)
			ids.each do |id|
				@internship.contact_interns.create(intern_user_id:id)
			end
			return render json:{ message: "created."}
		end

		def find_contact_intern
			@contact_intern = ContactIntern.find_by_id(params[:id])
			return render json: {error: "contact interns not found"}, status: 422 if @contact_intern.nil?
		end

		def applied_check?
			return render json: {error: "User needs to apply for internship"},status: 422 unless @internship.accounts.pluck("id").include?(params[:intern_user_id].to_i)
		end

		def check_contact_intern_count?
			return render json: {error: "You can not contact more than 3 interns."}, status: 422 if @internship.contact_interns.count >= 3
		end

		def find_internship
			@internship = @current_user.internships.find_by(status:1)
			return render json: { data: [] }, status: :not_found unless @internship.present?
		end

		def all_rejected?
			@contact_interns = ContactIntern.joins(:intern_user).where("accounts.is_blacklisted=? AND internship_id=?",false,@internship.id)
			count = @contact_interns&.count == 3
			all_rejected = @internship.contact_interns.where.not(decision: 2).count.zero? rescue nil
			if params[:action] == "unlock_candidates"
				return render json: {error: "You need to contact atleast 3 candidates."}, status: 422 unless count
				return render json: {error: "All candidates should be rejected"}, status: 422 unless all_rejected
			else
				@unlock_candidates = count && all_rejected
			end
		end

		def check_unlock_intern_count?
			return render json: {error: "You can not unlock candidates more than once"}, status: 422 if @internship.contact_interns.count == 6
		end	
	end
end