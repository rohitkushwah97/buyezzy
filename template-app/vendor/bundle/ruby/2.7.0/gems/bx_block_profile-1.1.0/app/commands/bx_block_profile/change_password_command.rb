# frozen_string_literal: true

module BxBlockProfile
  module ChangePasswordCommand
    extend self

    def execute(account_id, password, new_password)
      validator = ChangePasswordValidator
        .new(account_id, password, new_password)

      account = validator.account

      return [:unprocessable_entity, validator.errors.full_messages] unless validator.valid?
      return [:created, account] if update_password(account, new_password)

      [:unprocessable_entity, ['Password could not be saved']]
    end

    private

    def update_password(account, new_password)
      account.update password: new_password
    end
  end
end
# rubocop:enable Style/Documentation
