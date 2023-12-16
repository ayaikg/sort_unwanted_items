class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[edit update show destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user, :item).order(id: :asc).page(params[:page])
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post), success: t('defaults.message.updated')
    else
      flash.now['danger'] = t('defaults.message.not_updated')
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  def destroy
    @post.destroy!
    redirect_to admin_posts_path, success: t('defaults.message.deleted')
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:item_id, :content, :post_image, :post_image_cache)
  end
end
