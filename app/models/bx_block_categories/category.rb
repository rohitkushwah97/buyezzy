module BxBlockCategories
  class Category < BxBlockCategories::ApplicationRecord
    self.table_name = :categories

    has_many :sub_categories, class_name: "BxBlockCategories::SubCategory", foreign_key: :parent_id, dependent: :destroy
    has_many :mini_categories, through: :sub_categories, class_name: "BxBlockCategories::MiniCategory", source: :mini_categories, dependent: :destroy
    has_many :micro_categories, through: :mini_categories, class_name: "BxBlockCategories::MicroCategory", source: :micro_categories, dependent: :destroy

    validates :name, uniqueness: true, presence: true

    has_many :catalogues, class_name: "BxBlockCatalogue::Catalogue", dependent: :destroy
    has_many :parent_catalogues, class_name: "BxBlockCatalogue::ParentCatalogue"
    has_one :header_category, class_name: "BxBlockDashboard::HeaderCategory", dependent: :destroy

    has_many :custom_fields, as: :fieldable, class_name: "BxBlockCategories::CustomField", dependent: :destroy

    accepts_nested_attributes_for :custom_fields, allow_destroy: true

    has_one_attached :category_image, dependent: :destroy
    has_one_attached :header_image, dependent: :destroy
    before_validation :strip_name_whitespace

    has_one :most_popular_category, class_name: "BxBlockDashboard::MostPopularCategory", dependent: :destroy
    has_many :banners, class_name: "BxBlockDashboard::Banner", dependent: :destroy

    private

    def strip_name_whitespace
      self.name = name.strip if name.present?
    end
  end
end
