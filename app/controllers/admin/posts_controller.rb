class Admin::PostsController < ApplicationController
  def index
    @reported_posts = Post.joins(:reports).distinct.order(created_at: :desc)
    @posts = Post.includes(:user, images_attachments: :blob).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.includes(images_attachments: :blob).find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "投稿を削除しました"
  end
end
