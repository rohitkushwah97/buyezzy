FactoryBot.define do
  factory :custom_field, class: 'BxBlockCategories::CustomField' do
    field_name { "MyString" }
    data_type { "MyString" }
    mandatory { false }
    association :fieldable, factory: :category

    after(:build) do |custom_field|
      custom_field.custom_fields_options << FactoryBot.build(:custom_fields_option, custom_field: custom_field)
    end
    
  end
end
