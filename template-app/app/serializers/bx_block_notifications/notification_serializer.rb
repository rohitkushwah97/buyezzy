module BxBlockNotifications
  class NotificationSerializer
    include FastJsonapi::ObjectSerializer
    attributes *[
        :id,
        :headings,
        :contents,
        :app_url,
        :is_read,
        :read_at,
        :created_at,
        :updated_at,
        :account_id,
        :match_type,
        :navigates_to
    ]
  end
end
