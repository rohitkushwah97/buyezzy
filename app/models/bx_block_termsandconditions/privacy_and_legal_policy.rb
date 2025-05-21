module BxBlockTermsandconditions
  class PrivacyAndLegalPolicy < ApplicationRecord
    
    self.table_name = :bx_block_termsandconditions_privacy_nad_legal_policies
    
		validates :title, presence: true, uniqueness: true
    validates :content, presence: true
  end
end