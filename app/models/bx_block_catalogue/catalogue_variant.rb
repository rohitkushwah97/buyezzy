module BxBlockCatalogue
  class CatalogueVariant < BxBlockCatalogue::ApplicationRecord
    self.table_name = :catalogue_variants

    # belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
    belongs_to :micro_category, class_name: "BxBlockCategories::MicroCategory"
    belongs_to :seller, class_name: "AccountBlock::Account"
    has_many :variant_attributes, class_name: "BxBlockCatalogue::VariantAttribute", dependent: :destroy
    has_many :product_variant_groups,class_name: "BxBlockCatalogue::ProductVariantGroup"
    accepts_nested_attributes_for :variant_attributes, allow_destroy: true

    validates :group_name, presence: true, uniqueness: { scope: :seller_id }

    before_destroy :check_product_variant_groups

    private

    def check_product_variant_groups
        if product_variant_groups.exists?
            errors.add(:base, "Selected group has variants linked to it. Please review and delete the variants to delete the group.")
            throw :abort
        end
    end

  end
end
