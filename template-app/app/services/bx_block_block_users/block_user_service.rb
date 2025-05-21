module BxBlockBlockUsers
	class BlockUserService

		def initialize(account, current_user)
	      @account = account
	      @current_user = current_user
	    end

		def block_user
      		if intern?
	       		handle_internship_withdrawals_and_terminations
			elsif business?
				handle_intern_rejection_and_termination
			end
		end


		def handle_internship_withdrawals_and_terminations
		  internships = @account.internships

		  internships.each do |internship|
		    application = BxBlockNavmenu::AccountInternship.find_by(
		      account_id: @current_user.id,
		      internship_id: internship.id
		    )

		    next if application.nil?

		    if internship.start_date > Date.today
		      application.update(is_withdraw: true)
		    elsif internship.start_date <= Date.today && internship.end_date >= Date.today
		      application.update(is_terminate: true)
		    end
		  end
		end

		def handle_intern_rejection_and_termination
		  internships = @account.internships

		  internships.each do |internship|
		    application = BxBlockNavmenu::AccountInternship.find_by(
		      account_id: @current_user.id,
		      internship_id: internship.id
		    )

		    next if application.nil?

		    if internship.start_date > Date.today
		      application.update(status: "rejected")
		    elsif internship.start_date <= Date.today && internship.end_date >= Date.today
		      application.update(is_terminate: true)
		    end
		  end
		end

	    def intern?
	       @current_user.type == "InternUser"
	    end

	    def business?
	      @current_user.type == "BusinessUser"
	    end
	end
end