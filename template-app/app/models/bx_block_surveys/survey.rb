module BxBlockSurveys
  class Survey < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_surveys_surveys
    attr_accessor :skip_minimum_questions_validation, :weight

    belongs_to :role, class_name: "BxBlockCategories::Role"
    
    has_many :questions, -> (survey) { where(version_id: survey.versions.last&.id) }, class_name: 'BxBlockSurveys::Question', dependent: :destroy
    has_many :versions, class_name: 'BxBlockSurveys::Version', dependent: :destroy

    accepts_nested_attributes_for :questions, allow_destroy: true

    validates :name, presence: true, on: :create
    validate :sum_questions

    private

    def sum_questions
      errors.add(:name, 'The sum of default weight for all questions must be exactly 100.') if weight.present? && weight != 100
    end

    def minimun_one_question
      if at_least_question < 1
        errors.add(:questions, 'At least 1 Question must be added.')
      end
    end
  end
end

