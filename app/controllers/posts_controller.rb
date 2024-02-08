class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_disposal, only: [:new, :create, :edit, :update]
  before_action :set_categories_collection, only: [:index, :likes]

  def index
    @q = Post.preload(:likes).with_item.ransack(params[:q])
    @q.sorts = 'likes_count desc' if @q.sorts.empty?
    @posts = @q.result(distinct: true).page(params[:page])
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
      redirect_to posts_path, success: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), success: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: t('.success')
  end

  def likes
    @q = current_user.like_posts.preload(:likes).with_item.ransack(params[:q])
    @like_posts = @q.result(distinct: true).order(likes_count: :desc).page(params[:page])
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
    @disposal_items = current_user.items.includes(:user).after_disposal
  end

  def set_categories_collection
    @categories_collection = Category.roots.map { |p| [p.title, p.children.map { |c| [c.title, c.id] }] }
  end
end
