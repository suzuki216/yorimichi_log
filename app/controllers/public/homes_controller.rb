class Public::HomesController < ApplicationController
  def top
    @posts = Post.includes(:user, images_attachments: :blob).order(created_at: :desc).page(params[:page]).per(30)
  end

  def about
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(25)
  end
end
