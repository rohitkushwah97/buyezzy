ActiveAdmin.register BxBlockNavmenu::Internship, as: "Internships" do
  actions :index, :show
  remove_filter :business_user, :intern_user_generic_questions, :intern_user_generic_answers,
                :business_user_generic_answers, :user_survey, :accounts, :recommendations,
                :recommended_users, :contact_interns, :contacted_intern_users, :educational_statuses
  action_item :applicants, only: :show do
    link_to 'Applicants', applicants_admin_internship_path
  end
  filter :title
  filter :industry
  filter :role
  filter :work_location
  filter :work_schedule_id, as: :select, collection: -> {
    BxBlockSettings::WorkSchedule.all.map { |ws| [ws.schedule, ws.id] }
  }, label: "Work Schedule"
  filter :country
  filter :city
  filter :Contact_interns
  filter :start_date
  filter :end_date
  filter :monthly_salary
  filter :created_at
  filter :updated_at 
  filter :status, as: :select, collection: {
    "Draft" => 0,
    "Active" => 1,
    "Inactive" => 2
  }
  filter :duration
  

  index do
    selectable_column
    column "Internship ID", :id do |internship|
      link_to internship.id, admin_internship_path(internship)
    end
    column :title
    column :start_date
    column :end_date
    column :deadline_date
    column :monthly_salary
    column :industry
    column :role
    column :work_location
    column :work_schedule
    column :country
    column :city
    column :educational_status
    column :status
    column "Business User Email", sortable: 'business_user_id' do |internship|
      internship.business_user&.email || "No Business User Email"
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :start_date
      row :end_date
      row :deadline_date
      row :monthly_salary
      row :industry
      row :role
      row :work_location
      row :work_schedule
      row :country
      row :city
      row :educational_status
      row :status
      row "Business User Email" do |internship|
        internship.business_user&.email || "No Business User Email"
      end
    end
  end
  member_action :applicants, method: :get
  controller do
    def applicants
      @internship = resource
      @applicants = resource.accounts
      if @applicants.present?
        render '/admin/internships/applicants.html.erb'
      else
        redirect_to admin_internship_path(resource)
      end
    end
  end
end
