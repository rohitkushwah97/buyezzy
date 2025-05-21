FactoryBot.define do
  factory :deal, class: 'BxBlockCatalogue::Deal' do
    deal_name { "MyString" }
    deal_code { "MyString" }
    start_date { Date.today }
    end_date { Date.today }
    discount_type {'percentage'}
    discount_value { 0.0 }
    status { true }
  end
end
