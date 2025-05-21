require 'builder_base'

require 'bx_block_login'
require 'pundit'
require 'bx_block_posts'

unless Rails.env.production?
  require 'byebug'
  require 'rswag'
end

require 'bx_block_like_a_post/engine'

module BxBlockLikeAPost
  # Your code goes here...
end
