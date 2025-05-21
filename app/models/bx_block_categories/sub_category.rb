module BxBlockCategories
  class SubCategory < BxBlockCategories::ApplicationRecord
    self.table_name = :sub_categories

    belongs_to :category, class_name: "BxBlockCategories::Category", foreign_key: :parent_id
    has_many :mini_categories, class_name: "BxBlockCategories::MiniCategory", foreign_key: :sub_category_id, dependent: :destroy
    has_many :micro_categories, through: :mini_categories, class_name: "BxBlockCategories::MicroCategory", dependent: :destroy

    validates :name, uniqueness: true, presence: true

    has_many :catalogues, class_name: "BxBlockCatalogue::Catalogue"
    has_many :parent_catalogues, class_name: "BxBlockCatalogue::ParentCatalogue"

    has_many :custom_fields, as: :fieldable, class_name: "BxBlockCategories::CustomField", dependent: :destroy
    has_many :banners, class_name: "BxBlockDashboard::Banner", dependent: :destroy
    accepts_nested_attributes_for :custom_fields, allow_destroy: true

    before_validation :strip_name_whitespace

    private 
    
    def strip_name_whitespace
      self.name = name.strip if name.present?
    end

  end
end
