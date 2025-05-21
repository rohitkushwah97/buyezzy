module BxBlockLike
  class Like < BxBlockLike::ApplicationRecord
    self.table_name = :likes
    ACCOUNT = "AccountBlock::Account"

    belongs_to :likeable, polymorphic: true
    belongs_to :like_by, class_name: ACCOUNT

    # after_create :create_notification

    private

    def create_notification
      liked_type = (likeable_type == ACCOUNT) ? "profile" : "post"
      account = AccountBlock::Account.find(like_by_id)
      BxBlockPushNotifications::PushNotification.create(
        account_id: like_by_id,
        push_notificable_type: ACCOUNT,
        push_notificable_id: likeable.id,
        remarks: "#{account.first_name} #{account.last_name} \
                  liked your #{liked_type}"
      )
    end
  end
end
