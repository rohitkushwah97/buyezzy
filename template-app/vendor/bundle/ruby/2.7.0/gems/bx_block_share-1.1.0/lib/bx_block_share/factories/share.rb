FactoryBot.define do
  factory :share, class: "BxBlockShare::Share" do
    account
    shared_to_id { 1 }
    post
  end
end
