FactoryBot.define do
  factory :block_user, :class => 'BxBlockBlockUsers::BlockUser' do
    current_user_id { 1 }
    account_id { 1 }
  end
end
