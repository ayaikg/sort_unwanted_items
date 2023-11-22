class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_disposal, only: [:new, :create, :edit, :update]

  def index
    @posts = @q_header.result(distinct: true).includes(:user).order(created_at: :desc) if @q_header
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    return unless params[:item_id].present?

    @post.item_id = params[:item_id]
  end

  def edit; end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path
  end

  def likes
    @like_posts = @q_header.result(distinct: true).includes(:user).order(created_at: :desc) if @q_header
  end

  def search
    @posts = Post.where("advice like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :advice, :item_id)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def set_disposal
    @disposal_items = current_user.items.includes(:user).where.not(disposal_method: 0)
  end
end
