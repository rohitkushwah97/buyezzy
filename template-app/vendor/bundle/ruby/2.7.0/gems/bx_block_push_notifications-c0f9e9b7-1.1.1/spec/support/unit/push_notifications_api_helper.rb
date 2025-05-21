# spec/support/push_notifications_api_helper.rb
module PushNotificationsApiHelper
  def authenticated_header(request, user)
    token = BuilderJsonWebToken.encode(user.id)
    request.headers.merge!(token: "#{token}")
  end

  def create_seller params
    BxBlockCustomForm::SellerAccount.create(params)
  end

  def create_push_notification params
    BxBlockPushNotifications::PushNotification.create(params)
  end

  module JsonHelpers
    def json_response
      @json ||= JSON.parse(response.body, symbolize_names: true)
      puts @json
      @json
    end
  end
end
