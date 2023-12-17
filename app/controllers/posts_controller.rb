class PostsController < ApplicationController
  skip_before_action :require_login, only: :index
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_disposal, only: [:new, :create, :edit, :update]

  def index
    @q_header.sorts = 'likes_count desc' if @q_header.sorts.empty?
    @posts = @q_header.result(distinct: true).eager_load([:item, :user]).preload(:likes)
                             .where.not(items: { disposal_method: 0 })
                             .page(params[:page]) if @q_header
    @before_login_posts = Post.all.eager_load([:user, :item]).where.not(items: { disposal_method: 0 })
                             .order(likes_count: :desc).limit(10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    return if params[:item_id].blank?

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
    @like_posts = @q_header.result(distinct: true).eager_load([:item, :user]).preload(:likes)
                           .where.not(items: { disposal_method: 0 })
                           .order(created_at: :desc).page(params[:page]) if @q_header
  end

  private

  def post_params
    params.require(:post).permit(:content, :item_id, :post_image, :post_image_cache)
  end

  def set_post
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to(root_path, alert: t('defaults.message.forbidden_access')) unless @post
  end

  def set_disposal
    @disposal_items = current_user.items.includes(:user).where.not(disposal_method: 0)
  end
end
