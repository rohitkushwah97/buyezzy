FactoryBot.define do
  factory :size_and_capacity, class: 'BxBlockCatalogue::SizeAndCapacity' do
    size { 0 }
    size_unit { "Grams" }
    capacity { 0 }
    capacity_unit { "Litre" }
    hs_code { "455678" }
    prod_model_name { "MyString" }
    prod_model_number { "MyS45tring" }
    number_of_pieces { 1 }
    product_content
  end
end
