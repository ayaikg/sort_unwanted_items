class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
    @disposal_items = Item.where.not(disposal_method: 0)
    if params[:item_id].present?
      @item_info = Item.find(params[:item_id])
      @post.item_id = params[:item_id]
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:content, :advice, :item_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
