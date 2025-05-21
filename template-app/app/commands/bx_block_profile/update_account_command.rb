# frozen_string_literal: true

module BxBlockProfile
  module UpdateAccountCommand
    module_function

    def execute(account_id, params)
      validator = UpdateAccountValidator.new(account_id, params)

      return [:unprocessable_entity, validator.errors.full_messages] unless validator.valid?

      account = validator.account
      attrs = validator.attributes

      return [:ok, account.reload] if account.update(attrs)

      [:unprocessable_entity, ['Profile could not be saved']]
    end
  end
end

# rubocop:enable Style/Documentation
