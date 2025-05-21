ActiveAdmin.register BxBlockSurveys::Survey, as: 'SurveysQuestions' do
  actions :index, :show, :edit, :update
  permit_params :name, questions_attributes: [:id, :question_type, :question_title, :rating, :_destroy, :intern_characteristic_id, :default_weight, :business_question, :intern_question, :version_id, options_attributes: [:id, :name]]

  form do |f|
    f.semantic_errors *f.object.errors
    f.inputs do
      f.input :name, input_html: { disabled: true } 
      f.has_many :questions, allow_destroy: true do |q|
        q.input :intern_characteristic_id, as: :select, collection: BxBlockSurveys::InternCharacteristic.all.collect { |intern| [intern.name, intern.id] }, include_blank: false
        q.input :default_weight
        q.input :business_question
        q.input :intern_question

        5.times do |i|
          q.object.options.build if q.object.options[i].nil?
        end

        q.has_many :options, allow_destroy: false, new_record: false do |o|
          option_index = o.index + 1
          o.input :name, label: "Option #{option_index}", input_html: { value: o.object.name }
        end
      end
    end
    f.actions
  end

  member_action :questions do
    @version = BxBlockSurveys::Version.find(params["version_id"])
    render "questions"
  end

  collection_action :survey_index do
    @surveys = BxBlockSurveys::Survey.all
    render "survey_index"
  end

  show do |obj|
    attributes_table do
      row :name
      div class: 'panel', label: "Versions" do
        ul do
          obj.versions.each do |version|
            li do
              link_to version.name, questions_admin_surveys_question_path(obj, version_id: version.id)
            end
          end
        end
      end
    end
  end

  controller do

    def index
      redirect_to survey_index_admin_surveys_questions_path
    end

    def update
      check_weights
      if resource.valid? && is_valid?
        is_only_changed
        redirect_to admin_surveys_question_path
      else
        super
      end
    end

    private

    def check_weights
      weight_sum = 0
      params["survey"]["questions_attributes"].as_json.map {|k,v| v}.each do |que|
        next if que["_destroy"].to_i == 1
        weight_sum += que["default_weight"].to_i
      end
      resource.weight = weight_sum
    end

    def is_valid?
      arr = []
      params["survey"]["questions_attributes"].as_json.map{|k,v| v}.each do |que|
        arr << que["options_attributes"].map{|k,v| v}.pluck("name").exclude?("")
        arr <<  que.except!("options_attributes").values.exclude?("")
      end
      arr.exclude?(false)
    end

    def is_only_changed
      conds = []
      params["survey"]["questions_attributes"].as_json.map{|k,v| v}.each do |que|
        question = BxBlockSurveys::Question.find_by_id(que["id"])
        if question.present? && is_question_change?(question, que) && is_options_change?(question, que)
          conds << true
        else
          conds << false
        end
      end
      unless conds.any?(false)
        resource.update(questions_attributes: params["survey"]["questions_attributes"].as_json.map{|k,v| v})
        BxBlockRecommendation::CreateRecommendationsJob.perform_later(resource&.questions&.last&.version_id,resource.role_id)
      else
        question_cloned_version_assignment
      end
    end

    def is_question_change?(question, payload)
      ques = question.as_json.except("id","question_title", "created_at","updated_at", "sequence","question_type","rating","survey_id","version_id").map{|k,v| k unless payload[k] == v.to_s}.compact
      # (ques.include?("default_weight") || ques.include?("intern_characteristic_id")) && (ques.exclude?("intern_question") && ques.exclude?("business_question")) ? true : false
      (ques.exclude?("intern_question") && ques.exclude?("business_question")) ? true : false
    end

    def is_options_change?(question, payload)
      options1 = question.options.as_json.map{|rec| rec.except("question_id", "created_at", "updated_at")}.map { |h| h.transform_keys(&:to_s).transform_values(&:to_s) }.sort_by { |h| [h["id"], h["name"]] }
      options2 = payload["options_attributes"].as_json.map{|k,v| v.except("_destroy")}.map { |h| h.transform_keys(&:to_s).transform_values(&:to_s) }.sort_by { |h| [h["id"], h["name"]] }
      options1 == options2
    end

    def question_cloned_version_assignment
      questions = []
      params["survey"]["questions_attributes"].as_json.map{|k,v| v}.each do |que|
        question = BxBlockSurveys::Question.find_by_id(que["id"])
        if question.present?
          clone_q = question.deep_clone include: :options
          clone_q.save
          que["id"] = clone_q.id.to_s
          clone_q.options.each_with_index do |op,index|
            break if index==5
            que["options_attributes"][index.to_s]['id'] = op.id.to_s
            # que["options_attributes"].map{|k,v| v}.each do |o|
            #   o["id"] = op.id.to_s
            # end
          end
          resource.update(questions_attributes: [que])
          questions << clone_q
        else
          resource.update(questions_attributes: [que])
          questions << resource.questions.last
        end
      end
      version = resource.versions.create!(name: "Version #{resource.versions.count + 1}")
      BxBlockSurveys::Question.where(id: questions).update_all(version_id: version.id)
    end
  end
end
