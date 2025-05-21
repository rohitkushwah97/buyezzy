module BxBlockHelpCentre
  class Faq < BxBlockHelpCentre::ApplicationRecord
  	validates :question, :answer, :created_for, presence: true
    validates :created_for, inclusion: { in: ['Business user', 'Intern user', 'General FAQ'], message: "must be either 'Business user', 'Intern user' or 'General FAQ'" }
  end
end