FactoryBot.define do
	factory :activity_log, class: 'BxBlockActivitylog::ActivityLog' do
		user_type {'seller'}
		action {"Test action"}
		accessed_at { Time.current }
		details {"Created activity log"}
		trait :with_account do
			association :user, factory: :account
		end
	end
end
