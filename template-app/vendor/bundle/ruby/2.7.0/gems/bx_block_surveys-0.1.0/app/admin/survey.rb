module Survey; end

ActiveAdmin.register BxBlockSurveys::Survey, as: 'Survey' do
  permit_params :name, :description, :is_activated, questions_attributes: [:id, :question_type, :question_title, :rating, :_destroy, options_attributes: [:id, :name, :_destroy]]

  action_item :new_question, only: :show do
    link_to 'Add New Question', new_admin_question_path(survey_id: resource.id)
  end

  action_item :export_result, only: :show do
    link_to 'Export Survey Results', download_excel_admin_survey_path(resource), method: :post
  end

  index do
    selectable_column
    column 'Name of the Survey', :name
    column :description
    column 'Activated', sortable: :is_activated do |resource|
      content_tag(:span, resource.is_activated, style: "color: #{resource.is_activated ? '#07fd19' : '#ff0707'}")
    end
    actions
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs "Survey Details" do
      f.input :name, label: "Survey name", input_html: { style: 'width: 60%' }
      f.input :description, as: :text, input_html: { style: 'width: 60%; height: 40px' }
      f.input :is_activated, as: :boolean, input_html: { style: 'transform: scale(1.2)' }
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :is_activated
    end

    panel 'All Questions' do
      table_for resource.questions do
        column :question_type
        column :question_title
        column :rating do |question|
          question.rating.present? ? question.rating : '-'
        end
        column 'Options' do |question|
          if question.options.present?
            ul do
              question.options.each_with_index do |option, index|
                li "#{index + 1})   #{option.name}"
              end
            end
          else
            span 'No options available'
          end
        end
        column 'Actions' do |question|
          links = ''.html_safe
          links += link_to 'Edit', edit_admin_question_path(question), style: 'color: blue; text-decoration: underline; margin-right: 10px;'
          links += link_to 'Delete', admin_question_path(question), method: :delete, style: 'color: red; text-decoration: underline;', data: { confirm: 'Are you sure you want to delete this question?' }
          links
        end
      end
    end
  end

  controller do
    def download_excel
      survey = BxBlockSurveys::Survey.find(params[:id])
      return render json: { message: "Survey results are not present" }, status: :not_found unless survey.questions.present?

      csv_data = CSV.generate do |csv|
        csv << ["Survey Name", "Survey Description", "Question type", "Question Title", "Rating", "Options"]

        survey.questions.each do |question|
          answer = BxBlockSurveys::Submission.find_by(question_id: question.id)
          option_names = question.options.map(&:name).join(", ")
          csv << [
            survey.name,
            survey.description,
            question.question_type,
            question.question_title,
            question.rating.present? ? question.rating : '-',
            option_names
          ]
        end

        csv << []
        csv << ["Account Id", "User Name", "Question Title", "Answer"]

        account_ids = survey.questions.map { |question| BxBlockSurveys::Submission.where(question_id: question.id).pluck(:account_id) }.flatten.uniq.sort

        account_ids.each do |account_id|
          user_answers = survey.questions.map do |question|
            answer = BxBlockSurveys::Submission.find_by(question_id: question.id, account_id: account_id)

            options = BxBlockSurveys::Option.where(id: answer&.option_ids)&.pluck(:name)
            option_ids = answer&.option_ids.present? ? answer&.option_ids&.join(", ") : ""

            if answer&.rating.present?
              [
                account_id,
                answer&.account&.first_name,
                question.question_title,
                answer&.rating
              ]
            elsif answer&.option_ids.present?
              [
                account_id,
                answer&.account&.first_name,
                question.question_title,
                options.join(", ")
              ]
            else
              [
                account_id,
                answer&.account&.first_name,
                question.question_title,
                answer&.answer
              ]
            end
          end

          user_answers.each { |answer| csv << answer }
          csv << []
        end
      end

      send_data csv_data, filename: "#{survey.name}_survey_results.csv", type: "text/csv"
    end
  end
end
