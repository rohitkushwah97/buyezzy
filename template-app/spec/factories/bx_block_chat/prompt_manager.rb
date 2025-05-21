# spec/factories/bx_block_chat_prompt_managers.rb
FactoryBot.define do
  factory :prompt_manager, class: 'BxBlockChat::PromptManager' do
    criteria { "Sample criteria" }
  end
end
