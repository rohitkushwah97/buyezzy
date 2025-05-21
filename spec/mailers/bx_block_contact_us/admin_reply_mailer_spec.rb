require 'rails_helper'

RSpec.describe BxBlockContactUs::AdminReplyMailer, type: :mailer do
  let(:admin_reply) { create(:admin_reply) }

  describe 'notification' do
    let(:mail) { BxBlockContactUs::AdminReplyMailer.notification(admin_reply) }

    it 'renders the headers' do
      expect(mail.subject.strip).to eq('Admin Reply Notification')
    end
    it 'does not include attachments when image is not attached' do
      admin_reply.image.detach
      mail_without_image = BxBlockContactUs::AdminReplyMailer.notification(admin_reply)
      user_added_attachments = mail_without_image.attachments.reject do |attachment|
        attachment.content_id.nil? || attachment.content_id.start_with?('<')
      end
      expect(user_added_attachments).to be_empty
    end
    it 'does not include attachments when both image and contact image are not attached' do
      admin_reply.image.detach
      admin_reply.contact.image.detach
      mail_without_images = BxBlockContactUs::AdminReplyMailer.notification(admin_reply)
      user_added_attachments = mail_without_images.attachments.reject do |attachment|
        attachment.content_id.nil? || attachment.content_id.start_with?('<')
      end
      expect(user_added_attachments).to be_empty
    end
  end
end
