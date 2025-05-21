module BxBlockRecommendation
  class CalculateRange
    def calculate_range(compatibility_score,total_business_score,threshold_percentage,intern_user,internship,role_id,type)
      notification = intern_user&.notification_setting
      threshold_value = (total_business_score*threshold_percentage)/100
      range_mapping = {
        "Outstanding match" => 0..(threshold_value / 5),
        "Excellent match" => (threshold_value / 5)..(2 * threshold_value / 5),
        "Great match" => (2 * threshold_value / 5)..(3 * threshold_value / 5),
        "Very Good match" => (3 * threshold_value / 5)..(4 * threshold_value / 5),
        "Good match" => (4 * threshold_value / 5)..threshold_value
      }

      range_mapping.each do |name, range|
        if range.min <= compatibility_score && compatibility_score < range.max
          Recommendation.create!(intern_user_id: intern_user.id,internship_id: internship,match_type: name,score: compatibility_score,role_id: role_id)
          if notification&.turn_off_perfect_match_notifications && name == 'Outstanding match'
            heading =  "Perfect Match Opportunity"
            content = "New internship perfectly matching your profile is available. Apply now to seize this opportunity!"
            navigates_to = "ExactScore"
            notification_creator = BxBlockNotifications::NotificationCreator.new(intern_user, heading, content, navigates_to,name)
            notification_creator.call
          end

          if notification&.turn_off_recommendation_notifications && type == 'publish'
            heading =  "Check Your New Recommendation"
            content = "New internships have been added to your recommendations. Review them to see if they're a great fit!"
            navigates_to = "NewRecommendation"
            notification_creator = BxBlockNotifications::NotificationCreator.new(intern_user, heading, content, navigates_to,name)
            notification_creator.call
          end
        end
      end
    end
  end
end