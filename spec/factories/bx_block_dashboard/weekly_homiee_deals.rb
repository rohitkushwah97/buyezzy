FactoryBot.define do
  factory :weekly_homiee_deal, class: "BxBlockDashboard::WeeklyHomieeDeal" do
    start_time { Date.tomorrow }
	end_time { Date.tomorrow + 2.days }
	status {false}
  end
end
