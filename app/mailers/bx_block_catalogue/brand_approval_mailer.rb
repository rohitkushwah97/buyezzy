module BxBlockCatalogue
	class BrandApprovalMailer < ApplicationMailer
		def brand_approval_email
			@account = params[:account]
			@host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
      mail(
          to: @account.email,
          from: 'admin_notification@byezzy.com',
          subject: ' ByEzzy brand approval update') do |format|
        format.html { render 'brand_approval_email' }
      end
		end
	end
end