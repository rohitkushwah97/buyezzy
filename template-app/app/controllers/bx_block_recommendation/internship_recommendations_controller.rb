module BxBlockRecommendation
	class InternshipRecommendationsController < ApplicationController
		include BxBlockPagination::PaginationConcern
		before_action :validate_json_web_token,:authenticate_account
		before_action :intern?, except: %i(get_recommended_applicants destory_recommendations)
		before_action :check_account, only: %i(destory_recommendations) 

		def get_internsips_recommendation
			@internships = BxBlockNavmenu::Internship.joins(:recommendations,business_user: :company_detail).where(bx_block_recommendation_recommendations: {intern_user_id: @current_user.id},accounts:{is_blacklisted: false},status: 1)

			@internships = @internships.where('educational_statuses @> ARRAY[?]::integer[]', [(@current_user.school_education || @current_user.university_education)&.educational_status&.id])

			if params[:search].present?
				@internships = @internships.where("title ILIKE '%#{params[:search]}%' OR company_details.company_name ILIKE '%#{params[:search]}%'")
			end

			if params[:filter].present?
				@internships = BxBlockRecommendation::InternshipFilters.new.filter_internship(@internships,params[:filter])
			end
			@internships = @internships.where('deadline_date >= ?', Date.today) 
			blocked_by_business_users = BxBlockBlockUsers::BlockUser.where(account_id: @current_user.id).pluck(:current_user_id)
     		@internships = @internships.where.not(business_user_id: blocked_by_business_users) if blocked_by_business_users.any?
			paginate(collection: @internships.order('RANDOM()'), serializer:  BxBlockNavmenu::InternshipSerializer)
		end

		def get_recommended_applicants
			internship = @current_user.internships.find_by(status:1)
			if internship.present?
				@applicants = AccountBlock::InternUser.includes(:internships,:profile,:recommendations,:university_education,:school_education).where(bx_block_navmenu_internships:{id:internship.id},bx_block_recommendation_recommendations:{internship_id: internship.id},is_blacklisted: false)
				if params[:search].present?
					@applicants = @applicants.where("full_name ILIKE ?", "%#{params[:search]}%")
				end

				if params[:filter].present?
					@applicants = ApplicantFilter.new.filter_applicants(@applicants,params[:filter])
				end
				@list_blocked_users = BxBlockBlockUsers::BlockUser.where('current_user_id = ?', @current_user.id)
				@blocked_user_ids = @list_blocked_users.pluck(:account_id)
				@applicants = @applicants.where.not(id: @blocked_user_ids)
				recommended_applicants = @applicants.order('RANDOM()').limit(5)
				res = AccountBlock::InternUserSerializer.new(recommended_applicants,params: { internship: internship }).serializable_hash
				render json: res, status: status
			else
				render json: {data: [] }, status: :not_found
			end
		end

		def destory_recommendations
			BxBlockRecommendation::Recommendation.destroy_all
			render json: { message: "recommendations deleted" } ,status: 200
		end

		private

		def check_account
			return render json: { errors: 'You are not authorise to perform this action.'}, status: 401  unless @current_user.email == 'shivam@yopmail.com'
		end

		def paginate(collection:, serializer:)
			return render(json: serializer.new(collection).serializable_hash) if params[:show_all].present?

			object_counts = collection.count
			page = params[:page].to_i == 0 ? 1 : params[:page].to_i
			per_page = params[:per_page].to_i == 0 ? object_counts : params[:per_page].to_i
			collection = collection.page(page).per(per_page)

			data = serializer.new(collection,{params: {id:@current_user.id}}).serializable_hash

			data[:meta] = { pagination: {
				per_page: per_page,
				current_page: page,
				next_page: collection.next_page,
				total_count: object_counts,
				total_pages: per_page.zero? ? 0 : (object_counts.to_f / per_page).ceil 
			} }		

			render json: data ,status: 200
		end
	end
end