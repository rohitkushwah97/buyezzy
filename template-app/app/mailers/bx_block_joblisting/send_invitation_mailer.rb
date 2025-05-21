module BxBlockJoblisting
  class SendInvitationMailer < ApplicationMailer
    def send_invitation_email
      @email = params[:email]
      @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]

      @url = "#{@host}/bx_block_joblisting/company_pages"

      mail(
        to: @email,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'Company Page Invitation'
      ) do |format|
        format.html { render 'invitation_email' }
      end
    end

    def send_invitation_email_to_other_user
      @email = params[:email]
      @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]

      @url = "#{@host}/bx_block_joblisting/company_pages"

      mail(
        to: @email,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'Company Page Invitation'
      ) do |format|
        format.html { render 'invitation_email_other_user' }
      end
    end
  end
end
