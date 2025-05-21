module BxBlockChat
  class PromptVersion < BxBlockChat::ApplicationRecord
    self.table_name = :prompt_versions
    belongs_to :prompt_manager, class_name: "BxBlockChat::PromptManager"
    validates :description, presence: true
	end
end