module V1
  class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: %i[show update destroy]

    def index
      @pagy, @posts = pagy PostSearchService.new(Post.includes(:creator, :comments), params).call
    end

    def create
      post = current_user.posts.new(post_params)
      render_created(post) if post.save!
    end

    def show; end

    def update
      render_okay(@post) if @post.update!(post_params)
    end

    def destroy
      render_no_content if @post.destroy
    end

    private

    def post_params
      params.require(:post).permit(:title, :description)
    end

    def set_post
      @post = Post.find(params[:id])
    end
  end
end
