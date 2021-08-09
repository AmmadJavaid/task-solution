module V1
  class CommentsController < ApplicationController
    before_action :set_post, only: %i[create update destroy]
    before_action :set_comment, only: %i[update destroy]

    def create
      comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
      render_created(comment) if comment.save!
    end

    def update
      authorize @comment
      render_okay(@comment) if @comment.update!(comment_params)
    end

    def destroy
      authorize @comment
      render_no_content if @comment.destroy
    end

    private

    def comment_params
      params.require(:comment).permit(:message)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = @post.comments.find(params[:id])
    end
  end
end
