module BxBlockChat
  class ApplicationMailer < BuilderBase::ApplicationMailer
    default from: "admin_notification@byezzy.com"
    layout "mailer"
  end
end
