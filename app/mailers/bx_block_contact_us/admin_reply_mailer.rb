
module BxBlockContactUs
  class AdminReplyMailer < ApplicationMailer
    def notification(admin_reply)
      @admin_reply = admin_reply
      if @admin_reply.image.attached?
        attachments.inline[@admin_reply.image.filename.to_s] = @admin_reply.image.download
        @admin_image_url = attachments.inline[@admin_reply.image.filename.to_s].url
      else
        @admin_image_url = nil
      end
      if @admin_reply.contact.image.attached?
        attachments.inline[@admin_reply.contact.image.filename.to_s] = @admin_reply.contact.image.download
        @admin_contact_image_url = attachments.inline[@admin_reply.contact.image.filename.to_s].url
      else
        @admin_contact_image_url = nil
      end
      mail(to: admin_reply.contact.email, subject: ' Admin Reply Notification') 
    end
  end
end
