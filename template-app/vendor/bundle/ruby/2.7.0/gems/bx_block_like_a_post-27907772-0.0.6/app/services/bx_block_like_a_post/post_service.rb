module BxBlockLikeAPost
  class PostService
    attr_reader :like_post

    def initialize(likepost_params, current_user)
      @likepost_params = likepost_params
      @current_user = current_user
    end

    def like
      post_id = @likepost_params['post_id']
      likepost = LikePost.find_by(account_id: @current_user.id, post_id: post_id)

      return false, [{message: 'You already liked.'}] if likepost.present?

      @post = BxBlockPosts::Post.find_by(id: post_id)
      return false, [{message: 'Post does not exist.'}] if @post.nil?
      @like_post = LikePost.new(@likepost_params)
      @like_post.account_id = @current_user.id
      if @like_post.save
        true
      else
        [false, format_activerecord_errors(@like.errors)]
      end
    end

    def unlike
      post_id = @likepost_params['post_id']
      likepost = LikePost.find_by(account_id: @current_user.id, post_id: post_id)

      return false, [{message: 'Not liking this user.'}] unless likepost.present?

      if likepost.destroy
        true
      else
        [false, format_activerecord_errors(likepost.errors)]
      end
    end
  end
end
