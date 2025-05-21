module BxBlockContactUs
  class ContactsController < ApplicationController
#create contact us
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        BxBlockEmailNotifications::SendEmailNotificationService.with(to: "support@byezzy.com",from: "buyer_contact@byezzy.com", contact: @contact,subject: "New Contact - #{@contact.contact_type.to_s.capitalize}",file: 'new_contact_notification').notification.deliver_now

        render json: ContactSerializer.new(@contact).serializable_hash, status: :created
      else
        render json: {errors: [
            {contact: @contact.errors.full_messages},
        ]}, status: :unprocessable_entity
      end
    end

    def contact_params
      params.permit(:title, :email, :description, :contact_type, :image)
    end
  end
end