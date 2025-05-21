module BxBlockLogin
  class AccountAdapter
    include Wisper::Publisher

    def login_account(account_params)
      case account_params.type
      when 'sms_account'
        phone = Phonelib.parse(account_params.full_phone_number).sanitized
        account = AccountBlock::SmsAccount.find_by(
          full_phone_number: phone,
          activated: true)
      when 'email_account'
        email = account_params.email.downcase

        account = AccountBlock::Account
        .where('LOWER(email) = ?', email)
        .where(activated: true, user_type: account_params.user_type)
        .first
      when 'social_account'
        account = AccountBlock::SocialAccount.find_by(
          email: account_params.email.downcase,
          unique_auth_id: account_params.unique_auth_id,
          activated: true)
      end

      unless account.present?
        broadcast(:account_not_found)
        return
      end

      if account.authenticate(account_params.password)
        token, refresh_token = generate_tokens(account.id)
        document_status = get_document_status(account)
        last_visited_at = account.last_visit_at
        first_time_login = set_first_time_login(account)
        broadcast(:successful_login, account, token, refresh_token, document_status, last_visited_at, first_time_login)
      else
        broadcast(:failed_login)
      end
    end

    def generate_tokens(account_id)
      [
        BuilderJsonWebToken.encode(account_id, 1.day.from_now, token_type: 'login'),
        BuilderJsonWebToken.encode(account_id, 1.year.from_now, token_type: 'refresh')
      ]
    end

    def get_document_status(account)
      @seller_documents = account.seller_documents
      if @seller_documents.blank?
        "No documents uploaded"
      elsif @seller_documents.all?(&:approved?)
        "Your document has been verified"
      elsif @seller_documents.any?(&:rejected?)
        rejected_documents = @seller_documents.select(&:rejected?).map(&:document_name)
        "Rejected: #{rejected_documents.join(', ')}"
      else
        "Your Document verification is in progress"
      end
    end

    def set_first_time_login(account)
      if account.last_visit_at.nil? && @seller_documents.present? && @seller_documents.all?(&:approved?)
        account.update(last_visit_at: Time.now)
        return true
      else
        return false
      end
    end
  end
end
