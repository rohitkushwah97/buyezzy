module BxBlockSurveys
  class Question < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_surveys_questions
    
    belongs_to :survey, class_name: "BxBlockSurveys::Survey"
    belongs_to :version, class_name: "BxBlockSurveys::Version", optional: true
    belongs_to :intern_characteristic, class_name: "BxBlockSurveys::InternCharacteristic"#, optional: true
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
    #validates :question_title, presence: true
    validates :default_weight, :business_question, :intern_question, presence: true
    validates :default_weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: "must be between 0 and 100" }, on: :create
    validates :options, presence: { message: 'must have at least two options' }, if: :checkbox_question?
    #validate :minimum_two_options
    validate :must_have_five_options
    
    private

    def must_have_five_options
      if options.size != 5
          errors.add(:options, 'must have exactly 5 options')
      else
        options.each_with_index do |opt, index|
          unless opt.name.present?
            errors.add(:options, "Option #{index + 1} must have a name")
          end
        end
      end
    end

    # def minimum_two_options
    #   errors.add(:options, 'must have at least two options') if checkbox_question? && options.size < 2
    # end

    def checkbox_question?
      question_type.in?(%w[checkbox radio])
    end
  end
end
