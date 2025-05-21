ActiveAdmin.register BxBlockHelpCentre::Faq, as: 'FAQ' do
  menu label: 'FAQ'

  actions :all

  index do
    selectable_column
    id_column
    column :question
    column :created_for
    column 'Created At', :created_at
    column 'Updated At', :updated_at
    actions
  end

  show do
    attributes_table do
      row :question
      row :answer do |faq|
        strip_tags(faq.answer)
      end
      row :created_for
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :question, label: 'Question'
      f.input :answer, as: :quill_editor, label: 'Answer', input_html: { style: 'margin-left: 25px;' }
      f.input :created_for, as: :select, collection: ['Business user', 'Intern user', 'General FAQ'], prompt: 'Select Created For'
    end
    f.actions
  end


  permit_params :question, :answer, :created_for
end
