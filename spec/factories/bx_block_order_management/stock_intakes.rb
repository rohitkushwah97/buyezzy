FactoryBot.define do
  factory :stock_intake, class: 'BxBlockOrderManagement::StockIntake' do
    catalogue { nil }
    stock_value { "9.99" }
    stock_qty { 1 }
    ship_date { Date.tomorrow }
    receiving_date { Date.tomorrow + 2.days }
  end
end
