module BxBlockRecommendation
  class Recommendation < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_recommendation_recommendations
    belongs_to :intern_user, class_name: 'AccountBlock::InternUser',foreign_key: 'intern_user_id'
    belongs_to :internship, class_name: 'BxBlockNavmenu::Internship',foreign_key: 'internship_id'
    validates :match_type, presence: true

    validates :role_id, uniqueness: { scope: [:intern_user_id,:internship_id]}

    enum match_type: {"Outstanding match" => 0,  "Excellent match" => 1, "Great match" => 2, "Very Good match" => 3, "Good match"  => 4 }
  end
end