FactoryBot.define do
  factory :block_user, class: 'BxBlockBlockUsers::BlockUser' do
    account_id { create(:account).id }
    current_user_id { create(:account).id }
  end
end