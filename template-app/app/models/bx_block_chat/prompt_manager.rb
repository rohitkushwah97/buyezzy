module BxBlockChat
  class PromptManager < BxBlockChat::ApplicationRecord
    self.table_name = :prompt_managers
    has_many :prompt_versions, class_name: "BxBlockChat::PromptVersion", dependent: :destroy

	end
end