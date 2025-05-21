class ChangeAnswerColumnTypeInBxBlockHelpCentreFaqs < ActiveRecord::Migration[6.1]
  def change
    change_column :bx_block_help_centre_faqs, :answer, :text
  end
end
