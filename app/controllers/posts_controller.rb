class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    
    def index
        @posts = Post.all
        unless user_signed_in?
            @posts.each do |post|
            post.user = nil
            end
        end
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        if @post.save
            redirect_to action: "index"
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
    def post_params
        params.require(:post).permit(:title, :body)
    end
end
