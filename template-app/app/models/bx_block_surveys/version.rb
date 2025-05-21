module BxBlockSurveys
  class Version < BuilderBase::ApplicationRecord
    self.table_name = :versions

    validates :name, presence: true
    belongs_to :survey, class_name: "BxBlockSurveys::Survey"
    has_many :questions, class_name: "BxBlockSurveys::Question", dependent: :destroy

    #validate :unique_version_name_per_quiz
	  #before_validation :set_version_name
	  accepts_nested_attributes_for :questions, allow_destroy: true
	  default_scope { order(id: :asc) }
	  after_create :changed_user_survey_status

	  private

	  def changed_user_survey_status
	  	UpdateRetakeStatusJob.perform_now(self)
	  end

	  def unique_version_name_per_quiz
			return if self.persisted? && survey.versions.where(name: name).where.not(id: id).exists?

			if survey.versions.where(name: name).where.not(id: self.id).exists?
				errors.add(:name, "must be unique within the same quiz")
			end
	  end

	  def set_version_name
	    if name.blank?
	      next_version_number = survey.versions.count + 1
	      self.name = "Version #{next_version_number}"
	    end
	  end  
	end
end
