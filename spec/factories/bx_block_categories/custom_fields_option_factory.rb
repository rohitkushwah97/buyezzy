FactoryBot.define do
  factory :custom_fields_option, class: 'BxBlockCategories::CustomFieldsOption' do
    option_name { "My Option" }
    custom_field
  end
end
