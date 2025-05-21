module BxBlockProjectreporting
  class Project < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_projectreporting_projects
    STATUS = {completed: 'Completed', ongoing: 'On Going', yet_to_be_started: 'Yet to be started'}
    enum project_type: { virtual: 0, assessor: 1, hybrid: 2 }
    validates_presence_of :start_date, :end_date, :project_type
    validates :name, presence: {message: "Name can't be blank"},uniqueness: {message: "Name already exists", case_sensitive: false}
    validates :client_id, uniqueness: {:scope=> [:start_date, :end_date], message: "has already been taken."}

    belongs_to :client, class_name: 'AccountBlock::Client'
    belongs_to :manager, class_name: 'AccountBlock::Manager'
    belongs_to :co_manager, class_name: 'AccountBlock::CoManager'
    belongs_to :account, class_name: 'AccountBlock::Account'

    def tools
      BxBlockAdmin::OnlineTool.where(id: self.online_tool_ids)
    end
    
    def get_status
      if self.end_date.to_date < Date.today
        STATUS[:completed]
      elsif (self.start_date.to_date..self.end_date.to_date).include?(Date.today)
        STATUS[:ongoing]
      else
        STATUS[:yet_to_be_started]
      end
    end

  end
end
