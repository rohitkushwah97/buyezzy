module BxBlockProjectreporting
	class ProjectsController < BxBlockProjectreporting::ApplicationController
    include BxBlockProjectreporting::ErrorHandler

		def create
	      project = BxBlockProjectreporting::Project.new(input_params)
	      project.account_id = current_user.id
	      if project.save
	        return render json: BxBlockProjectreporting::ProjectSerializer.new(project).serializable_hash, status: :created
	      else
	        return render json: { errors: format_activerecord_errors(project.errors) }, status: :unprocessable_entity
	      end
	    end

		def index
			@projects = current_user.projects
			@projects = @projects.where(id: BxBlockProfile::AssessorParticipantSlot.where(participant_id: params[:participant_ids]).pluck(:project_id)) if params[:participant_ids].present? && BxBlockProfile::AssessorParticipantSlot.where(participant_id: params[:participant_ids]).pluck(:project_id).uniq.present?
			@projects = @projects.where('name ilike ?', "%#{params[:project_name]}%") if params[:project_name].present?
			@projects = @projects.where('start_date > ?', params[:start_date]) if params[:start_date].present?
			@projects = @projects.where('end_date <= ?', params[:end_date]) if params[:end_date].present?

			@projects = @projects.where(project_type: params[:project_type]) if params[:project_type].present?
			@projects = @projects.where(client_id: params[:client_ids]) if params[:client_ids].present?
			@projects = @projects.where(account_id: params[:admin_ids]) if params[:admin_ids].present?
			@projects = @projects.where(manager_id: params[:manager_ids]) if params[:manager_ids].present?
			@projects = @projects.where(co_manager_id: params[:co_manager_ids]) if params[:co_manager_ids].present?
			@projects = @projects.where('assessor_ids && ARRAY[?]', params[:assessor_ids]) if params[:assessor_ids].present?
			@projects = @projects.order('created_at desc').includes(:client, :manager, :co_manager, :account, :participant, documents: :project)

			respond_to do |format|
				format.html { render json: BxBlockProjectreporting::ProjectSerializer.new(@projects).serializable_hash, status: :ok }
				format.json { render json: BxBlockProjectreporting::ProjectSerializer.new(@projects).serializable_hash, status: :ok }
			    format.csv do
			    	response.headers['Content-Type'] = 'text/csv'
				    response.headers['Content-Disposition'] = "attachment; filename=project_#{DateTime.now.to_i}.csv"
				    render template: "bx_block_projectreporting/projects/index.csv.erb"
			    end
			    format.xlsx do
				    response.headers['Content-Disposition'] = "attachment; filename=project_#{DateTime.now.to_i}.xlsx"
				    render template: "bx_block_projectreporting/projects/index.xlsx.axlsx"
			    end
			end
		end

		private

	    def input_params
	      params.permit(
	        :name,
	        :project_type,
	        :manager_id,
	        :co_manager_id,
	        :client_id,
	        :participant_id,
	        :start_date,
	        :end_date,
	        :max_score,
	        :is_negative_marking,
	        :negative_mark,
	        :duration,
	        question_ids: [],
	        online_tool_ids: [],
	        assessor_tool_ids: [],
	        assessor_ids: [],
	        documents_attributes: [:id, :doc_type, doc: [:data]]
	      )
	    end

	end
end
