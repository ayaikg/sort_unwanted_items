class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_disposal, only: [:new, :create, :edit, :update]

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
    if params[:item_id].present?
      @post.item_id = params[:item_id]
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def likes
    @like_posts = current_user.like_posts.includes(:user).order(created_at: :desc)
  end

  private
  def post_params
    params.require(:post).permit(:content, :advice, :item_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_disposal
    @disposal_items = Item.where.not(disposal_method: 0)
  end
end
