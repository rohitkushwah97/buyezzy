module BxBlockSurveys
  class Question < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_surveys_questions
    
    belongs_to :survey, class_name: "BxBlockSurveys::Survey"
    has_many :submissions, class_name: 'BxBlockSurveys::Submission', dependent: :destroy
    has_many :options, class_name: 'BxBlockSurveys::Option', dependent: :destroy
    accepts_nested_attributes_for :options, allow_destroy: true
    
    enum question_type: {
      'text' => 'text',
      'rating' => 'rating',
      'radio' => 'radio',
      'checkbox' => 'checkbox'
    }
    
    validates :rating, presence: true, if: -> { question_type == 'rating' }
    validates :question_title, :question_type, presence: true
    validates :options, presence: { message: 'must have at least two options' }, if: :checkbox_question?
    validate :minimum_two_options
    
    private

    def minimum_two_options
      errors.add(:options, 'must have at least two options') if checkbox_question? && options.size < 2
    end

    def checkbox_question?
      question_type.in?(%w[checkbox radio])
    end
  end
end
