module BxBlockNavmenu
  class ChangeInternshipStatusJob < ApplicationJob
    queue_as :default
 
    def perform
      internships = Internship.active.where('start_date <= ?', Date.current)
      if internships.present?
        internships.update_all(status: "inactive")
        puts "Internships are inactive sucessfully."
      else
        puts "Active internships are not available."
      end
    end
  end
end