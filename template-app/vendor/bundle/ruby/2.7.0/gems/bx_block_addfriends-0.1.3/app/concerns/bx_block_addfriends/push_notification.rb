# This concern has been added to the repo, as it was omitted in the extraction
# of the block in `https://gitlab.builder.ai/clientprojects/assembler_projects/prd/alislinkedin-43286-ruby/-/merge_requests/410`
#
# The `BxBlockPushnotifications` block itself, seems to work quite differently
# to the expectation of this more recent (lite certified) implementation, so if
# it ever gets integrated with this repo in future, it might cause obscure errors,
# and conflicts in behaviour.

require 'fcm'

module BxBlockAddfriends
  module PushNotification
    extend ActiveSupport::Concern
    FCM_SEVER_KEY = 'AAAAdgsIpGI:APA91bH5OHm_Knht4zcp1nuVclaFH7GcnQYylbobuLU1ortupQ1KX5ht26rFwBU-WB9wAjHlXdYPEt0ACrjpxg0LW-FY-Ouvx0MG9ubPydDSfd0vEaCUNXc-mf4DD6RKEElovXtWob9k'

    def send_notification(user, message, body, resource_type = nil, resource = nil, sender_name = nil, reviewer_id = nil)
      registration_ids = user&.devices&.pluck(:device_token) rescue nil
      fcm_client = FCM.new(FCM_SEVER_KEY)
      options = { priority: 'high',
      data: { message: message, resource_type: resource_type, resource_id: resource&.id, sender_name: sender_name, reviewer_id:  reviewer_id },
      notification: {
      body: body,
      sound: 'default'                }
     }

      return response = fcm_client.send(registration_ids,options)
    end

    def send_bulk_notifications(user_ids, message, body, resource_type = nil, meeting = nil)
      users = AccountBlock::Account.where(id: user_ids)
      registration_ids = users.map { |user| user&.devices&.pluck(:device_token) rescue nil }.flatten
      fcm_client = FCM.new(FCM_SEVER_KEY)
      options = { priority: 'high',
      data: { message: message, resource_type: resource_type, meeting_id: meeting&.id },
      notification: {
      body: body,
      sound: 'default'                }
     }

      return response = fcm_client.send(registration_ids.uniq,options)
    end

    def send_chat_notification(sender, body)
      user = AccountBlock::Account.find_by_email(sender[:sender_email])
      registration_ids = user&.devices&.pluck(:device_token)&.uniq rescue nil
      fcm_client = FCM.new(FCM_SEVER_KEY)
      body = body
      options = { priority: 'high',
      data: { message: "text", data: body, resource_type: 'chat', sender: sender[:sender_name]},
      notification: {
      body: body,
      sound: 'default'                }
     }

      return response = fcm_client.send(registration_ids,options)
    end
  end
end
