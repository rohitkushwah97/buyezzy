module BxBlockDashboard
	class BannersController < ApplicationController
		before_action :load_banners, only: %i[header_slideshow_index header_single_images_index middle_slideshow_index middle_single_images_index footer_single_images_index]

		def header_slideshow_index
			render_banners
		end

		def header_single_images_index
			render_banners
		end

		def middle_slideshow_index
			unless params[:group_name]
				return render json: {
					message: "group_name params is missing send middle_group_1 or 2"
				}, status: :not_found 
			end
			render_banners
		end

		def middle_single_images_index
			render_banners
		end

		def footer_single_images_index
			render_banners
		end

		def top_banner
			top_banner = Banner.find_by(banner_type: "top_banner", status: true)
			render json: BannerSerializer.new(top_banner).serializable_hash, status: :ok
		end

		private

		def load_banners
			if section_param == 'middle'
				@banners = Banner.where(section: 'middle', banner_type: banner_type_param, banner_group_id: banner_group_id_param)
			else
				@banners = Banner.where(section: section_param, banner_type: banner_type_param)
			end
		end

		def section_param
			case action_name
			when 'header_slideshow_index', 'header_single_images_index'
				'header'
			when 'middle_slideshow_index', 'middle_single_images_index'
				'middle'
			else
				'footer'
			end
		end

		def banner_type_param
			case action_name
			when 'header_slideshow_index', 'middle_slideshow_index'
				'slideshow'
			else
				'single_image'
			end
		end

		def render_banners
			render json: BannerSerializer.new(@banners).serializable_hash, status: :ok
		end

		def banner_group_id_param
			banner_group = BannerGroup.find_by(group_name: params[:group_name])
			banner_group.id if banner_group
		end

	end
end
