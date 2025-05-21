module BxBlockStoreManagement
	class StoreSerializer < BuilderBase::BaseSerializer
		attributes :id, :store_name, :store_year, :store_url, :website_social_url, :approve, :created_at, :updated_at

		attributes :store_menus do |object|
			if object.store_menus
				object.store_menus.order(position: :asc).map {|menu| menu.serializable_hash}
			end
		end

		attributes :brand_trade_certificate do |object|
			if object.brand_trade_certificate.attached?
				ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(object.brand_trade_certificate, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(object.brand_trade_certificate, only_path: true)
			end
		end

		attributes :store_dashboard_sections do |object|
			if object.store_dashboard_sections
				object.store_dashboard_sections.order(created_at: :asc).map { |store_dashboard_section| BxBlockStoreManagement::StoreDashboardSectionSerializer.new(store_dashboard_section).serializable_hash }
			end
		end

		attribute :brand do |object|
			object.brand&.serializable_hash
		end

		attribute :account do |object|
	      AccountBlock::AccountSerializer.new(object.account)
	    end

	end
end