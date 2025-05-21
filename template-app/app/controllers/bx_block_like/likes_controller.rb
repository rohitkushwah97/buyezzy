module BxBlockLike
  class LikesController < ApplicationController
    before_action :authenticate_account
    POST = "BxBlockPosts::Post"
    def index
      likes = if likeable_type
        BxBlockLike::Like.where(
          like_by_id: current_user.id,
          likeable_type: likeable_type
        )
      else
        BxBlockLike::Like.where(like_by_id: current_user.id)
      end

      if likes.present?
        render json: BxBlockLike::LikeSerializer.new(likes).serializable_hash,
          status: :ok
      else
        render json: {data: []}, status: :ok
      end
    end

    def get_likes_on_a_post
      page = (params[:page] || 1).to_i
      per_page = (params[:per_page] || 10).to_i
      likes = BxBlockLike::Like.where(likeable_id: params[:likeable_id], likeable_type: POST).page(page).per(per_page)
      if likes.present?
        render json: {
            data: BxBlockLike::LikeSerializer.new(likes, params: {current_user: current_user}).serializable_hash[:data],
            meta: {
              pagination: {
                current_page: likes.current_page,
                per_page: likes.limit_value,
                total_pages: likes.total_pages,
                total_items: likes.total_count
              }
            }
          }, status: :ok
      else
        render json: {
          errors: [
            {message: "No likes."}
          ]
        }, status: :ok
      end
    end

    def create
      like = BxBlockLike::Like.find_or_initialize_by(
        like_params.merge({like_by: current_user})
      )
      if like.save
        render json: BxBlockLike::LikeSerializer.new(like, params: {current_user: current_user}).serializable_hash,
          status: :created
      else
        render json: {errors: [{like: like.errors.full_messages}]},
          status: :unprocessable_entity
      end
    end
    
    def destroy
      likeable_type = params[:likeable_type].eql?("post") ? POST : "BxBlockComments::Comment"
      like = BxBlockLike::Like.find_by(
        likeable_id: params[:likeable_id], likeable_type: likeable_type, like_by_id: current_user.id
      )
      if like.present?
        like.delete
        render json: {message: "Like is removed "},
          status: :ok
      else
        render json: {message: "Not found"},
          status: :not_found
      end
    end

    private

    def like_params
      params.permit(:likeable_id, :likeable_type)
    end


    def likeable_type
      return if params[:like_type].blank?
      (params[:like_type] == "profile") ?
      ["BxBlockProfile::Profile", "BxBlockProfile::CareerExperience",
        "BxBlockProfile::Award", "BxBlockProfile::TestScoreAndCourse",
        "BxBlockProfile::Course", "BxBlockProfile::EducationalQualification",
        "BxBlockProfile::Project", "BxBlockComments::comment"] : POST
    end

    def handle_create_response(like)
      if like.persisted?
        render json: BxBlockLike::LikeSerializer.new(like).serializable_hash,
          status: :ok
      else
        render json: {errors: [{like: like.errors.full_messages}]},
          status: :unprocessable_entity
      end
    end
  end
end
