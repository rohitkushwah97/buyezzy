class CreateBxBlockHelpCentreFaqs < ActiveRecord::Migration[6.1]
  def change
    create_table :bx_block_help_centre_faqs do |t|
      t.string :question
      t.string :answer
      t.string :created_for

      t.timestamps
    end
  end
end
