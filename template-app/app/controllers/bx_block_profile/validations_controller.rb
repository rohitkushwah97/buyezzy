# frozen_string_literal: true

module BxBlockProfile
  class ValidationsController < ApplicationController

    def index
      render json: {
        data: [{
          email_validation_regexp: email_regex,
          password_validation_regexp: password_regex,
          password_validation_rules: password_rules
        }]
      }
    end

    private

    def email_regex
      AccountBlock::EmailValidation.regex_string
    end

    def password_regex
      AccountBlock::PasswordValidation.regex_string
    end

    def password_rules
      AccountBlock::PasswordValidation.rules
    end
  end
end
# rubocop:enable Style/Documentation
