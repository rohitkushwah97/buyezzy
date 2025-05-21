module BxBlockDashboard
	class Banner < BxBlockDashboard::ApplicationRecord
		self.table_name = :banners

		enum banner_type: {
			single_image: 0,
			slideshow: 1,
            top_banner: 2
		}

		enum section: {
			header: 0,
			middle: 1,
			footer: 2
		}

		belongs_to :banner_group, class_name: 'BxBlockDashboard::BannerGroup', optional: true

		has_one_attached :banner_image, dependent: :destroy

        validates :title, :button_text, :banner_type, presence: true

		validates :description, :section, :banner_image, presence: true, unless: -> {banner_type == BxBlockDashboard::Banner.banner_types.keys.last}

        validates :button_link, presence: true, if: -> {banner_type == BxBlockDashboard::Banner.banner_types.keys.last}

		belongs_to :category, class_name: "BxBlockCategories::Category", foreign_key: "category_id", optional: true
    	belongs_to :sub_category, class_name: "BxBlockCategories::SubCategory", optional: true
    	belongs_to :deal, class_name: "BxBlockCatalogue::Deal", optional: true
    	belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue", optional: true

    	validate :at_least_one_reference_present, unless: -> {banner_type == "top_banner"}
    	validate :only_one_reference_attached, unless: -> {banner_type == "top_banner"}

    	private

    	def at_least_one_reference_present
    		unless category_id.present? || sub_category_id.present? || deal_id.present? || catalogue_id.present?
    			errors.add(:base, "At least one of category, sub category, deal, or catalogue must be present")
    		end
    	end

    	def only_one_reference_attached
    		references = [category_id, sub_category_id, deal_id, catalogue_id]
    		if references.count(&:present?) > 1
    			errors.add(:base, "Only one of category, sub category, deal, or catalogue can be attached")
    		end
    	end
	end
end

