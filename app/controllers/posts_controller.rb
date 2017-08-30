class PostsController < ApplicationController
  before_action :require_logged_in, except: [:index, :show]
  before_action :require_post_ownership, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def index
    @posts = Post.all
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post
      @post.destroy
      redirect_to sub_posts_url(@post.subs)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to post_url(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids:[])
  end

  def require_post_ownership
    @post = Post.find_by(id: params[:id])
    unless current_user == @post.author
      flash[:errors]=["Cannot modify someone else\'s post!"]
      redirect_to post_url(@post)
    end
  end
end
