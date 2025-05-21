module BxBlockJoblisting
  class JobReportService
    attr_accessor :job_id, :job_reports_under_twenty_percent, :job_reports_under_fourty_percent, :job_reports_under_sixty_percent, :job_reports_under_eighty_percent, :job_reports_under_hundered_percent

    def initialize(job_id)
      @job_id = job_id
      @job_reports_under_twenty_percent, @job_reports_under_fourty_percent,
      @job_reports_under_sixty_percent, @job_reports_under_eighty_percent,
      @job_reports_under_hundered_percent = [],[],[],[],[]
    end

    def job_report_according_to_skills_name
      begin
        job&.applied_jobs&.each do |applied_job|
          begin
            candidate_skills = candidate_skills(applied_job)
            percentage =  calculate_percentage(required_skills, candidate_skills)
            adding_profile_to_corresponding_array(percentage, applied_job)
          rescue StandardError => e
            e.message
          end
        end

          profiles_under_twenty_percent = profiles_according_to_percentage(job_reports_under_twenty_percent)
          profiles_under_fourty_percent = profiles_according_to_percentage(job_reports_under_fourty_percent)
          profiles_under_sixty_percent = profiles_according_to_percentage(job_reports_under_sixty_percent)
          profiles_under_eighty_percent = profiles_according_to_percentage(job_reports_under_eighty_percent)
          profiles_under_hundered_percent = profiles_according_to_percentage(job_reports_under_hundered_percent)

        {
          match_twenty_percent: "#{profiles_under_twenty_percent&.to_f}%",
          match_fourty_percent:"#{ profiles_under_fourty_percent&.to_f}%",
          match_sixty_percent:"#{ profiles_under_sixty_percent&.to_f}%",
          match_eighty_percent:"#{ profiles_under_eighty_percent&.to_f}%",
          match_hundered_percent:"#{ profiles_under_hundered_percent&.to_f}%",
          profiles_under_twenty_percent: job_reports_under_twenty_percent,
          profiles_under_fourty_percent:job_reports_under_fourty_percent,
          profiles_under_sixty_percent: job_reports_under_sixty_percent,
          profiles_under_eighty_percent: job_reports_under_eighty_percent,
          profiles_under_hundered_percent: job_reports_under_hundered_percent
        }

      rescue StandardError => e
        e.message
      end
    end

    def required_skills
      job&.required_skills&.uniq&.map{|rs| rs&.skill&.skill_name}
    end

    def candidate_skills(applied_job)
      applied_job&.profile&.candidate_skills&.uniq&.map{ |cs| cs&.skill&.skill_name}
    end

    def job
      return job = BxBlockJoblisting::Job&.includes(:required_skills, applied_jobs: [profile: [:candidate_skills]])&.find_by(id: job_id)
      raise 'Job not found' unless job.present?
    end

    def total_profiles
      # return raise 'No job application found for this job' unless job&.applied_jobs.present?
      job&.applied_jobs&.joins(:profile)&.count(:profile_id)
    end

    def adding_profile_to_corresponding_array(percentage, applied_job)
      if (0..20).include? percentage
        job_reports_under_twenty_percent << applied_job&.profile.map_json
      elsif (21..40).include? percentage
        job_reports_under_fourty_percent << applied_job&.profile.map_json
      elsif (41..60).include? percentage
        job_reports_under_sixty_percent << applied_job&.profile.map_json
      elsif (61..80).include? percentage
        job_reports_under_eighty_percent << applied_job&.profile.map_json
      elsif (81..100).include? percentage
        job_reports_under_hundered_percent << applied_job&.profile.map_json
      end
    end

    def calculate_percentage(candidate_skills, required_skills)
      return ((required_skills & candidate_skills)&.size*100) / required_skills&.size
    end

    def profiles_according_to_percentage(job_reports_array)
      return job_reports_array&.size*100/total_profiles
    end
  end
end
