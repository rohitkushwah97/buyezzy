module BxBlockSupport
	class SocialPlatform < ApplicationRecord
		self.table_name = :social_platforms
		validates :social_media ,:social_media_url, presence: true, uniqueness: true

		has_one_attached :social_icon, dependent: :destroy

		validate :validate_social_icon_type

		def validate_social_icon_type
			allowed_types = %w(image/jpeg image/jpg image/png image/webp)

			if social_icon.attached? && !social_icon.content_type.in?(allowed_types)
				errors.add(:social_icon, 'must be a JPEG/JPG/PNG/WebP file')
			end
		end
	end
end
