class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:post][:category_name].present?
      @post.category = Category.find_or_create_by(name: params[:post][:category_name])
    end

    if @post.save
      redirect_to public_post_path(@post), notice: "投稿しました"
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if params[:post][:remove_image_ids].present?
      params[:post][:remove_image_ids].each do |image_id|
        image = @post.images.find(image_id)
        image.purge
      end
    end

    if params[:post][:images].present?
      params[:post][:images].each do |image|
        @post.images.attach(image)
      end
    end

    if @post.update(post_params.except(:images))
      redirect_to public_post_path(@post), notice: "投稿を更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @post.images.purge
    @post.destroy
    redirect_to public_posts_path, notice: "投稿を削除しました"
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_name, images: [])
  end
end
