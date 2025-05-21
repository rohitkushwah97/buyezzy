# frozen_string_literal: true
module BxBlockJoblisting
  class Job < BuilderBase::ApplicationRecord
    self.table_name = 'bx_block_joblisting_jobs' 
    # belongs_to :profile, class_name: 'BxBlockProfile::Profile', optional: true
    validates :job_title, presence: true
    has_one_attached :job_video
    belongs_to :company_page, class_name: 'BxBlockJoblisting::CompanyPage', optional: true
    # has_many :required_skills, class_name: 'BxBlockJoblisting::RequiredSkill'
    # has_many :skills, :through => :required_skills, class_name: 'BxBlockJoblisting::Skill'
    # has_many :applied_jobs, class_name: 'BxBlockJoblisting::AppliedJob', dependent: :destroy
  end
end
 