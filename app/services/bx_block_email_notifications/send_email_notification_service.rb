module BxBlockEmailNotifications
  class SendEmailNotificationService < ApplicationMailer

    def notification
      @account = params[:account]
      @host = Rails.env.development? ? "http://localhost:3000" : ENV['FE_URL']
      @product = params[:product]
      @otp = params[:pin]
      @to = @account.present? ? @account.email : params[:to]
      @order = params[:order]
      @order_item = params[:order_item]
      @wms_event = params[:wms_event]
      @subject = params[:subject]
      @contact = params[:contact]
      @from = params[:from] ? params[:from] : "admin_notification@byezzy.com"

      mailer_call(@from, @to, @subject, params[:file])
    end

    private

    def mailer_call(from, to, subject, file)
      mail(
        to: to,
        from: from,
        subject: subject
        ) do |format|
        format.html { render file }
      end
    end
  end
end
