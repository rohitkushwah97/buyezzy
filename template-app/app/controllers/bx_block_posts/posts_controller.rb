module BxBlockPosts
  class PostsController < ApplicationController

    include BuilderJsonWebToken::JsonWebTokenValidation

    VIDEO = "video/"
    IMAGE = "image/"
    IMAGEJPEG = "image/jpeg"

    before_action :validate_json_web_token, :authenticate_account
    # before_action :check_image_video_formate, only: [:create,:update]
    before_action :check_account_activated
    # before_action :check_category, only: [:create,:update]
    # before_action :check_sub_category, only: [:create,:update]

    def index
      posts = BxBlockPosts::Post.all
      if posts.present?
        render json: PostSerializer.new(posts, params: {current_user: current_user}).serializable_hash
      else

        render json: {data: []},
            status: :ok
      end
    end

    def users_all_posts
      page = (params[:page] || 1).to_i
      per_page = (params[:per_page] || 10).to_i
      account = AccountBlock::Account.find_by(id: params[:user_id])
      return render json: {error: "user not exist"}, status: :not_found if account.nil?
      posts = account.posts.order(updated_at: :desc).page(page).per(per_page)
      if posts.present?
        render json: {
            data: PostSerializer.new(posts, params: {current_user: current_user}).serializable_hash[:data],
            meta: {
              pagination: {
                current_page: posts.current_page,
                per_page: posts.limit_value,
                total_pages: posts.total_pages,
                total_items: posts.total_count
              }
            }
          }, status: :ok
      else
        render json: {data: []}, status: :ok
      end
    end

    def activity_feed_posts
      page = (params[:page] || 1).to_i
      per_page = (params[:per_page] || 10).to_i

      followings = current_user.follows
      following_posts = BxBlockPosts::Post.where(account_id: followings.pluck(:follow_id))
      paginated_posts = following_posts.order(updated_at: :desc).page(page).per(per_page)

      if paginated_posts.present?
        render json: {
          data: PostSerializer.new(paginated_posts, params: {current_user: current_user}).serializable_hash[:data],
          meta: {
            pagination: {
              current_page: paginated_posts.current_page,
              per_page: paginated_posts.limit_value,
              total_pages: paginated_posts.total_pages,
              total_items: paginated_posts.total_count
            }
          }
        }, status: :ok
      else
        render json: { data: [] }, status: :ok
      end
    end

    def create
      validation_result = validate_upload_conditions
      return render json: validation_result[:error], status: validation_result[:status] if validation_result[:error]
      new_post = @current_user.posts.new(post_params)
      if new_post.save
        upload_post_images(new_post,params[:images])if params[:images].present?
        # media(new_post,params[:media]) if params[:media].present?
        render json: PostSerializer.new(new_post).serializable_hash,
               status: :ok
      else
        render json: ErrorSerializer.new(new_post).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def show
      post = BxBlockPosts::Post.find_by(id: params[:id])

      return render json: {errors: [
          {Post: 'Not found'},
        ]}, status: :not_found if post.blank?
      json_data = PostSerializer.new(post, params: {current_user: current_user}).serializable_hash
      render json: json_data
    end

    # def update
    #   post = BxBlockPosts::Post.find_by(id: params[:id], account_id: current_user.id)
    #   return render json: {errors: [
    #       {Post: 'Not found'},
    #     ]}, status: :not_found if post.blank?
    #   validation_result = validate_upload_conditions
    #   return render json: validation_result[:error], status: validation_result[:status] if validation_result[:error]

    #   post.images.destroy_all
    #   if post.update(post_params)
    #     upload_post_images(post,params[:images])if params[:images].present?
    #     render json: PostSerializer.new(post, params: {current_user: current_user}).serializable_hash
    #   else
    #     render json: {errors: format_activerecord_errors(post.errors)},
    #         status: :unprocessable_entity
    #   end
    # end

    def update
      post = find_post
      return render_not_found unless post

      validation_result = validate_upload_conditions(post)
      return render_validation_error(validation_result) if validation_result[:error]

      handle_images(post)

      if post.update(post_params)
        upload_post_images(post, params[:images]) if params[:images].present?
        render json: PostSerializer.new(post, params: { current_user: current_user }).serializable_hash
      else
        render json: { errors: format_activerecord_errors(post.errors) }, status: :unprocessable_entity
      end
    end

    def search
      @posts = Post.where('description ILIKE :search', search: "%#{search_params[:query]}%")
      render json: PostSerializer.new(@posts, params: {current_user: current_user}).serializable_hash, status: :ok
    end

    def destroy
      post = BxBlockPosts::Post.find_by(id: params[:id], account_id: current_user.id)
      render(json: { errors: 'post not found' }, status: :not_found) and return if post.nil?
      if post.destroy
        render json: {message: "Post deleted succesfully!"}, status: :ok
      else
        render json: ErrorSerializer.new(post).serializable_hash,
               status: :unprocessable_entity
      end
    end

    private

    def find_post
      BxBlockPosts::Post.find_by(id: params[:id], account_id: current_user.id)
    end

    def render_not_found
      render json: { errors: [{ Post: 'Not found' }] }, status: :not_found
    end

    def render_validation_error(result)
      render json: result[:error], status: result[:status]
    end

    def handle_images(post)
      if params[:images_to_keep].present?
        keep_ids = parse_images_to_keep
        post.images.each do |img|
          img.purge unless keep_ids.include?(img.id) || keep_ids.include?(img.blob_id)
        end
      else
        post.images.destroy_all
      end
    end

    def parse_images_to_keep
      if params[:images_to_keep].is_a?(String)
        params[:images_to_keep].split(',').map(&:to_i)
      elsif params[:images_to_keep].is_a?(Array)
        params[:images_to_keep].map(&:to_i)
      else
        []
      end
    rescue JSON::ParserError
      []
    end

    def validate_upload_conditions(post = nil)
      new_files = params[:images] || []

      kept_ids = params[:images_to_keep].present? ? parse_images_to_keep : []

      existing_attachments = post.present? ? post.images.where(id: kept_ids) : []

      existing_images_count = existing_attachments.select { |file| file.content_type.start_with?(IMAGE) }.size
      existing_videos_count = existing_attachments.select { |file| file.content_type.start_with?(VIDEO) }.size

      new_images = new_files.select { |file| file.content_type.start_with?(IMAGE) }
      new_videos = new_files.select { |file| file.content_type.start_with?(VIDEO) }

      total_images = existing_images_count + new_images.size
      total_videos = existing_videos_count + new_videos.size

      if total_images > 4
        return { error: { error: 'You can only upload up to 4 images' }, status: :unprocessable_entity }
      end

      if total_videos > 1
        return { error: { error: 'You can only upload 1 video' }, status: :unprocessable_entity }
      end

      size_check = validate_file_size(new_images, 5.megabytes, 'Image file size should not exceed 5 MB.')
      return size_check if size_check[:error]

      size_check = validate_file_size(new_videos, 20.megabytes, 'Video file size should not exceed 20 MB.')
      return size_check if size_check[:error]

      { error: nil, status: :ok }
    end

    def validate_file_count(files, max_count, error_message)
      if files.size > max_count
        { error: { error: error_message }, status: :unprocessable_entity }
      else
        { error: nil }
      end
    end

    def validate_file_size(files, max_size, error_message)
      files.each do |file|
        if file.size >= max_size
          return { error: { error: error_message }, status: :unprocessable_entity }
        end
      end
      { error: nil }
    end

    def post_params
      # params.permit(
      #   :name, :description, :body, :category_id,:sub_category_id, :location,
      #   tag_list: [],
      #   images: [],
      #   location_attributes: [:id, :address, :_destroy]
      # )
      params.require(:post).permit(:name, :description, :body, :category_id, :sub_category_id, :location, :account_id, images: [])
    end

    def search_params
      params.permit(:query)
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

    def check_image_video_formate
      return if params[:images].blank?
      image_formats = %w(IMAGEJPEG image/jpg image/png)
      video_formats = %w(video/mp4 video/mov video/wmv video/flv video/avi video/mkv video/webm)
      params[:images].each do |image_data|
        content_type = image_data[:content_type]
        if image_formats.exclude?(image_data[:content_type]) && content_type == 'image'
          render json: {errors: ["The image is unsupported type, supported formates are #{image_formats}"]},
            status: :unprocessable_entity
        elsif video_formats.exclude?(image_data[:content_type]) && content_type == 'video'
          render json: {errors: ["The video is unsupported type, supported formates are #{video_formats}"]},
            status: :unprocessable_entity
        end
      end
    end

    def upload_post_images(post, images_params)
      images_params.each do |file|
        next unless file.is_a?(ActionDispatch::Http::UploadedFile)

        if file.content_type.start_with?(IMAGE)
          post.images.attach(
            io: file.tempfile,
            filename: file.original_filename,
            content_type: file.content_type
          )
          begin
            require "image_processing/mini_magick"
            thumbnail_tempfile = Tempfile.new(['thumb', '.jpg'], binmode: true)
            ImageProcessing::MiniMagick
              .source(file.tempfile)
              .resize_to_limit(300, 300)
              .call(destination: thumbnail_tempfile.path)

            thumbnail_tempfile.rewind

            post.image_thumbnails.attach(
              io: thumbnail_tempfile,
              filename: "thumb_#{file.original_filename}.jpg",
              content_type: IMAGEJPEG
            )
          ensure
            thumbnail_tempfile.close!
          end

        elsif file.content_type.start_with?(VIDEO)
          post.images.attach(
            io: file.tempfile,
            filename: file.original_filename,
            content_type: file.content_type
          )
          begin
            movie = FFMPEG::Movie.new(file.tempfile.path)
            screenshot_path = Rails.root.join("tmp/#{SecureRandom.hex}.jpg")
            movie.screenshot(screenshot_path.to_s, seek_time: 2)

            File.open(screenshot_path) do |thumbnail_file|
              post.video_thumbnails.attach(
                io: thumbnail_file,
                filename: "thumb_#{file.original_filename}.jpg",
                content_type: IMAGEJPEG
              )
            end

            File.delete(screenshot_path) if File.exist?(screenshot_path)

          rescue => e
            Rails.logger.error "Thumbnail generation failed: #{e.message}"
          end
        end
      end
    end


    def media(post,images_params)
      images_to_attach = []

      images_params.each do |image_data|
        if image_data[:data]
          decoded_data = Base64.decode64(image_data[:data].split(',')[0])
          images_to_attach.push(
            io: StringIO.new(decoded_data),
            content_type: image_data[:content_type],
            filename: image_data[:filename]
          )
        end
      end
      post.media.attach(images_to_attach) if images_to_attach.size.positive?
    end

    def check_category
      @category = BxBlockCategories::Category.find_by(id: params[:category_id])
      unless @category
        render json: {message: "Category ID does not exist"},
          status: 404
      end
    end

    def check_sub_category
      @sub_category = BxBlockCategories::SubCategory.find_by(id: params[:sub_category_id])
      unless @sub_category
        render json: {message: "Sub_category ID does not exist"},
          status: 404
      end
    end
  end
end
