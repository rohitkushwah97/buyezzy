ActiveSupport.on_load(:post) do
  BxBlockPosts::Post.include(
    BxBlockLike::PatchBxBlockPostsAssociations
  )
end
