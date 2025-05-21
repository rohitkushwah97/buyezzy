module BxBlockNotifications
  class NotificationsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token
    before_action :authenticate_account
    before_action :current_user

    def index
      notifications = Notification.where(account_id: current_user.id)
      paginate_response(notifications,serializer: BxBlockNotifications::NotificationSerializer)
    end

    def unread_notifications
      notifications = Notification.where(account_id: current_user.id, is_read: false).first.present?
      render json: {unread_notifications: notifications}, status: :ok
    end

    def show
      notification = Notification.find(params[:id])
      render json: NotificationSerializer.new(notification, meta: {
          message: "Success."}).serializable_hash, status: :ok
    end

    def create
      notification = current_user.notifications.new(notification_params)
      if notification.save
        render json: NotificationSerializer.new(notification, meta: {
            message: "Notification created."}).serializable_hash, status: :created
      else
        render json: {errors: format_activerecord_errors(notification.errors)},
               status: :unprocessable_entity
      end
    end

    def update
      notification = Notification.find(params[:id])
      if notification.update(is_read: true, read_at: DateTime.now)
        render json: NotificationSerializer.new(notification, meta: {
          message: "Notification marked as read."}).serializable_hash, status: :ok
      else
        render json: {errors: format_activerecord_errors(notification.errors)},
               status: :unprocessable_entity
      end
    end

    def destroy
      notification = Notification.find(params[:id])
      if notification.destroy
        render json: {message: "Deleted."}, status: :ok
      else
        render json: {errors: format_activerecord_errors(notification.errors)},
               status: :unprocessable_entity
      end
    end

    def mark_all_read
      unread_notifications = Notification.where(account_id: current_user.id, is_read: false)      
      if unread_notifications.update_all(is_read: true)
        render json: { message: 'All notifications marked as read.' }, status: :ok
      else
        render json: { errors: [{ message: 'Failed to mark notifications as read.' }] }, status: :unprocessable_entity
      end
    end

    def mark_as_read 
      unread_notification = BxBlockNotifications::Notification.find(params[:id])
      if unread_notification.update(is_read: true)
        render json: { message: 'Your notification is marked as read.' }, status: :ok
      else
        render json: { errors: [{ message: 'Failed to mark notifications as read.' }] }, status: :unprocessable_entity
      end
    end

    private

     def paginate_response(objects,serializer:)
      if params[:per_page].to_i.zero?
        res = serializer.new(objects).serializable_hash
        return render json: res, status: :ok
      end

      page = params[:page].to_i == 0 ? 1 : params[:page].to_i
      per_page = params[:per_page].to_i

      objects = objects.page(page).per(per_page)

      res = serializer.new(objects).serializable_hash

      res[:meta] = { pagination: {
        per_page: per_page,
        current_page: objects.current_page,
        next_page: objects.next_page,
        prev_page: objects.previous_page,
        total_pages: objects.total_pages,
        total_count: objects.total_entries
      } }
      render json: res, status: :ok
    end

    def notification_params
      params.require(:notification).permit(
        :headings, :contents, :app_url, :account_id
      ).merge(created_by: current_user.id, account_id: current_user.id)
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end
  end
end
