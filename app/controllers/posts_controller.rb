class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post[:user_id] = current_user.id

    if @post.save
      redirect_to posts_path, notice: 'Created successfully!'
    else
      render :new 
    end
  end 

  def edit
  end 

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post updated!'
    else
      render :edit  
    end
  end 

  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Post deleted successfully'
  end 

  private 

  def find_post
    @post = Post.find(params[:id])
  end 

  def post_params
    params.require(:post).permit(:title, :body)
  end 
end
