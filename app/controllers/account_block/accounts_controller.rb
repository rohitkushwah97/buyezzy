module AccountBlock
  class AccountsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, only: [:logged_user, :upload_image]

    def create
      account_params = jsonapi_deserialize(params)
      query_email = account_params["email"].downcase&.strip
      accounts = Account.where("LOWER(email) = ? AND activated = ?", query_email, false)

      accounts.delete_all if accounts
      user_type = params["data"]["user_type"]

      case user_type
      when "seller"
        create_seller_account(account_params, query_email)
      when "buyer"
        create_buyer_account(account_params, query_email)
      else
        render json: { errors: [{ accounts: "Unknown user type" }] }, status: :unprocessable_entity
      end
    end

    def show
      @account = Account.find(params[:id])
      render json: AccountSerializer.new(@account).serializable_hash, status: :ok
    rescue ActiveRecord::RecordNotFound
      render_account_not_found_error
    end

    def update
      account_params = jsonapi_deserialize(params)
      @account = Account.find(params[:id])

      if account_params['current_password'].present? && account_params['new_password'].present?

        if BCrypt::Password.new(@account.password_digest) == account_params['current_password']
          @account.password = account_params['new_password']
        else
          return render json: { error: 'Incorrect current password' }, status: :unprocessable_entity
        end
      end

      if account_params['full_name'].present?
        @account.first_name, @account.last_name = account_params['full_name'].split(' ', 2)
      end

      if account_params['email'].present? && account_params['email'] != @account.email
        validator = EmailValidation.new(account_params['email'])
        if Account.exists?(email: account_params['email']) || !validator.valid?
          return render json: { error: 'Email invalid' }, status: :unprocessable_entity
        end
        @account.email = account_params['email']
      end

      if @account.update(account_params.except('current_password', 'new_password'))
        render json: AccountSerializer.new(@account).serializable_hash.merge(message: response_message_by_attributes(account_params, @account)), status: :ok
      else
        render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render_account_not_found_error
    end

    def destroy
      account = Account.find(params[:id])
      user_type = account.user_type.capitalize
      user_name = account.full_name
      user_email = account.email
      account.destroy
      BxBlockActivitylog::ActivityLog.create(
          user_type: user_type,
          user_email: user_email,
          action: "#{user_type} Account Destroyed",
          details: "#{user_name} account has been deleted",
          accessed_at: Time.current
          )
      render json: { message: 'Account deleted successfully' }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render_account_not_found_error
    end

    def account_activation
      if params[:token].present? 
        token = decode(params[:token])
        @account = AccountBlock::Account.find_by(id: token.id)
        @buyer_account = AccountBlock::Account.order(created_at: :desc).find_by(email: @account&.email, user_type: 'buyer', activated: false)
      else
        render json: { errors: "Invalid token" }, status: :unprocessable_entity
        return
      end

      if @account and !@account.activated
        if @account.update(activated: true)
          @buyer_account.update(activated: true) if @buyer_account
          EmailValidationMailer.with(account: @account, host: request.base_url).welcome_email.deliver_now
          activity_log(@account,"Account Activated", "#{@account.full_name} account has been activated")
          render json: AccountSerializer.new(@account, meta: { token: encode(@account.id), message: "Your account has been successfully activated. Please continue registration" }).serializable_hash, status: :ok
        else
          render json: {
            errors: format_activerecord_errors(@account.errors)
          }, status: :unprocessable_entity
        end
      else
        render json: { 
          errors: "Invalid activation link. Please try again or contact support."
        }, status: :ok
      end
    end

    def resend_email
      token = decode(params[:token])
      @account = AccountBlock::Account.find(token.id)
      EmailValidationMailer.with(account: @account, host: request.base_url).activation_email.deliver_now
      render json: { message: "Activation email has been resent" }, status: :ok
    end

    def logged_user
      @account = Account.find(@token.id)
      if @account.present?
        render json: AccountSerializer.new(@account).serializable_hash, status: :ok
      else
        render json: {errors: "account does not exist"}, status: :ok
      end
    end

    def upload_image
      account = Account.find(@token.id)
      profile_picture = upload_image_params[:profile_picture]
    
      if profile_picture
        account.profile_picture.attach(profile_picture)
        message = "Profile picture updated successfully!"
      else
        account.profile_picture.purge
      end
      activity_log(account,"#{account.user_type} #{message}", "#{message} by #{account.full_name}")
      render json: AccountSerializer.new(account).serializable_hash, status: :ok
    end

    private

    def encode(id)
      BuilderJsonWebToken.encode id
    end

    def decode(id)
      BuilderJsonWebToken.decode id
    end

    def render_account_not_found_error
      render json: { error: 'Account not found' }, status: :not_found
    end

    def create_seller_account(account_params, query_email)
      store_name = account_params['company_or_store_name'] ? account_params['company_or_store_name']&.strip : nil
      @account = Account.new(
        first_name: account_params['first_name']&.strip,
        last_name: account_params['last_name']&.strip,
        company_or_store_name: store_name,
        email: query_email,
        full_phone_number: account_params['full_phone_number'],
        password: account_params['password'],
        user_type: "seller"
        )

      buyer_account = Account.new(
        first_name: account_params['first_name']&.strip,
        last_name: account_params['last_name']&.strip,
        email: query_email,
        full_phone_number: account_params['full_phone_number'],
        password: account_params['password'],
        user_type: "buyer"
        )

      @account.platform = request.headers["platform"].downcase if request.headers.include?("platform")

      if account_params['password'] != account_params['confirm_password']
        render json: { errors: [{ accounts: "Password and confirm password should be the same" }] }, status: :unprocessable_entity
        return
      end

      ActiveRecord::Base.transaction do
        if @account.save
          if buyer_account.save
            message = "Seller and Buyer accounts created successfully"
            activity_log(@account,"New #{@account.user_type.capitalize} and #{buyer_account.user_type.capitalize} Created!!", "#{message},#{buyer_account.full_name} not yet activated")
            render json: {
              message: message,
              token: encode(@account.id),
              seller: AccountSerializer.new(@account).serializable_hash,
              buyer: AccountSerializer.new(buyer_account).serializable_hash
            }, status: :created
          else
            message = "Seller account created, but buyer account already exists"
            activity_log(@account,"New #{@account.user_type.capitalize} Created!!", "#{message},#{@account.full_name} not yet activated")
            render json: {
              message: message,
              token: encode(@account.id),
              seller: AccountSerializer.new(@account).serializable_hash,
              errors: format_activerecord_errors(buyer_account.errors)
            }, status: :created
          end
        else
          render json: { errors: format_activerecord_errors(@account.errors) }, status: :unprocessable_entity
          raise ActiveRecord::Rollback
        end
      end
    end

    def create_buyer_account(account_params, query_email)
      @account = Account.new(
        first_name: account_params['first_name']&.strip,
        last_name: account_params['last_name']&.strip,
        email: query_email,
        full_phone_number: account_params['full_phone_number'],
        password: account_params['password'],
        user_type: "buyer"
        )

      save_and_render_account(@account, "Buyer account is created")
    end

    def save_and_render_account(account, message = nil)
      if account.save
        activity_log(account,"New #{account.user_type.capitalize} Created!!", message)
        meta = { token: encode(account.id) }
        meta[:message] = message if message
        render json: AccountSerializer.new(account, meta: meta).serializable_hash, status: :created
      else
        render json: { errors: format_activerecord_errors(account.errors) }, status: :unprocessable_entity
      end
    end

    def upload_image_params
      params.permit(:profile_picture)
    end

    def response_message_by_attributes(account_params, account)
      user_type = account.user_type.capitalize
      if account_params.keys.sort == ['current_password', 'new_password'] && account_params.keys.size == 2
        message = "Password updated successfully!"
        activity_log(account,message, "#{user_type} has updated his/her password successfully")
        message
      elsif account_params.keys.size > 1 || account_params.keys.empty?
        message = "Profile updated successfully!"
        activity_log(account,message, "#{user_type} has updated his/her profile successfully")
        message
      elsif account_params.keys.include?('full_name')
        message = "Seller name updated successfully!"
        activity_log(account,message, "#{user_type} has updated his/her full name successfully")
        message
      elsif account_params.keys.include?('company_or_store_name')
        message = "Store name updated successfully!"
        activity_log(account,message, "#{user_type} has updated his/her company/store name successfully")
        message
      else
        updated_attributes = account_params.keys.map { |param| param.gsub('_', ' ').capitalize }
        message = "#{updated_attributes.first} updated successfully!"
        activity_log(account,message, "#{user_type} has updated his/her #{updated_attributes.first} successfully")
        message
      end
    end

    def activity_log(user, message, details)
      BxBlockActivitylog::ActivityLog.create(
          user: user,
          action: message,
          details: details,
          accessed_at: Time.current
          )
    end

  end
end

