FactoryBot.define do
  factory :catalogue_content, class: "BxBlockCatalogue::CatalogueContent" do
    custom_field_name { "MyString" }
    value { "MyString" }
    catalogue
    custom_field
    status { false }
  end
end
