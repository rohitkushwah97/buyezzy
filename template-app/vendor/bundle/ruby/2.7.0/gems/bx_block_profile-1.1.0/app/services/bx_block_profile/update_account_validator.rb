# frozen_string_literal: true

module BxBlockProfile
  class UpdateAccountValidator
    include ActiveModel::Validations

    ATTRIBUTES = [
      [:first_name],
      [:last_name],
      %i[new_phone_number full_phone_number],
      %i[new_password password],
      %i[new_email email]
    ].freeze

    attr_accessor(*ATTRIBUTES.map(&:first), :current_password)

    validates :account, presence: {message: 'not found'}
    validates :first_name, presence: {allow_nil: true}
    validates :last_name, presence: {allow_nil: true}
    validate :validate_phone_number
    validate :validate_email
    validate :validate_password

    def initialize(account_id, params)
      @account_id = account_id

      @current_password = params[:current_password]

      params.each_key do |key|
        send "#{key}=", params[key]
      end
    end

    def account
      return @account if defined?(@account)

      @account = AccountBlock::Account.find_by(id: @account_id)
    end

    def attributes
      return {} unless valid?

      attrs = {}

      ATTRIBUTES.each do |values|
        source = values.first
        dest = values.last

        value = send(source)
        attrs[dest] = value if value
      end

      attrs
    end

    private

    def validate_phone_number
      return unless new_phone_number

      validator = ChangePhoneValidator.new(@account_id, new_phone_number)
      validate_with_validator validator
    end

    def validate_password
      return if !current_password && !new_password

      validator = ChangePasswordValidator
        .new(@account_id, current_password, new_password)
      validate_with_validator validator
    end

    def validate_email
      return unless new_email

      validator = ChangeEmailValidator.new(@account_id, new_email)
      validate_with_validator validator
    end

    def validate_with_validator(validator)
      return if validator.valid?

      validator.errors.each do |attr, message|
        errors.add attr, message
      end
    end
  end
end
