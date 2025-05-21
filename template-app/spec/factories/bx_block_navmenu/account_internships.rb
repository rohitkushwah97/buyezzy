FactoryBot.define do
  factory :accounts_bx_block_navmenu_internships, class: 'BxBlockNavmenu::AccountInternship' do
    association :account, factory: :account  # assumes you have an :account factory
    association :internship, factory: :bx_block_navmenu_internship  # assumes you have a :bx_block_navmenu_internship factory
    is_withdraw { false }
    is_terminate { false }
    status { 'pending' }
    created_at { Time.current }
    updated_at { Time.current }
  end
end
