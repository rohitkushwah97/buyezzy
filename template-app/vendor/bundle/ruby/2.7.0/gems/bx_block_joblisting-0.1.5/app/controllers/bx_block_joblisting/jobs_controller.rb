module BxBlockJoblisting
  class JobsController < ApplicationController
    def index
      @jobs = BxBlockJoblisting::Job.all
      render json: BxBlockJoblisting::JobSerializer.new(@jobs, serialization_options).serializable_hash, status: :ok
    end

    def job_posted_by_current_user
      jobs = current_user&.profiles&.first&.jobs
      if jobs.present?
        render json: BxBlockJoblisting::JobSerializer.new(jobs, serialization_options).serializable_hash, status: :ok
      else
        render json: { message: "Record not found!"}, status: :not_found
      end  
    end

    def create
      job = BxBlockJoblisting::Job.create(job_params)
      begin
        job.save!
        render json: BxBlockJoblisting::JobSerializer.new(job, serialization_options).serializable_hash, status: :created
      rescue  
        render json: {message: "Job not created"}, status: :not_found
      end
    end

    def show
      job = BxBlockJoblisting::Job.find_by(id: params[:id])
      if job.present?
        # create_job_performance_record
        render json: BxBlockJoblisting::JobSerializer.new(job, serialization_options).serializable_hash, status: :ok
      else
        render json: { meta: { message: 'Record not found.' } }, status: :not_found
      end
    end

    def destroy
      job = BxBlockJoblisting::Job.find(params[:id])
      if job&.destroy
        render json: { meta: { message: 'Job Removed' } }
        # else
        #   render json:{meta: {message: "Record not found."}}
      end
    end

    def update
      job = BxBlockJoblisting::Job.find_by(id: params[:id])
      if job.present? && job.update(job_params)
        render json: BxBlockJoblisting::JobSerializer.new(job, serialization_options).serializable_hash, status: :ok
      else
        render json: { meta: 'record not found' },
               status: :not_found
      end
    end

    private

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

    def current_user
      @account = AccountBlock::Account.find_by(id: @token.id)
    end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port } }
    end

    # def create_required_skills(job, required_skills)
    #   required_skills&.each do |skill|
    #     job&.required_skills&.create(skill_id: skill)
    #   end
    # end

    # # def create_job_performance_record
    #   BxBlockJoblisting::JobPerformance.find_or_create_by(account_id: current_user.id, job_id: params[:id])
    # end

    # def upload_file(object_key)
    #   signer = UploadPresigner.new.signer
    #     url = signer.presigned_url(
    #     :put_object,
    #     bucket: 'sbucket',
    #     key: object_key,
    #     acl: 'public-read'
    #   )
    # end

    def job_params
      params.require(:job).permit \
        :profile_id,
        :job_title,
        :remote_job,
        :location,
        :employment_type_id,
        :total_inteview_rounds,
        :job_description,
        :company_page_id,
        :job_video,
        :salary,
        :seniority_level,
        :job_function,
        :industry_id,
        :job_video_url,
        :sub_emplotyment_type,
        question_answer_id: [],
        skill_id: [],
        other_skills: [],
        preffered_location: [],
        addresses: []
    end
  end
end
