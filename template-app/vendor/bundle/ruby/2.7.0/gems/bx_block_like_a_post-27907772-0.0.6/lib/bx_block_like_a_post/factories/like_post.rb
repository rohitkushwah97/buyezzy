FactoryBot.define do
  factory :like_post, class: 'BxBlockLikeAPost::LikePost' do
    post
    account
  end
end
