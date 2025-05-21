module BxBlockTermsAndConditions
  module PatchAccountBlockAssociations
    extend ActiveSupport::Concern

    included do
      has_many :user_terms_and_conditions,
        class_name: "BxBlockTermsAndConditions::UserTermAndCondition",
        dependent: :destroy, foreign_key: :terms_and_condition_id
    end
  end
end
