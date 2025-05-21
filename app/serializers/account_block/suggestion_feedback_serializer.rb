module AccountBlock
  class SuggestionFeedbackSerializer < BuilderBase::BaseSerializer
   include FastJsonapi::ObjectSerializer
   attributes *[
    :detail_type,
    :detail,
    :first_name,
    :last_name,
    :email,
    :created_at
  ]

  attributes :account do |object|
    object.account&.serializable_hash
  end
 end
end