class Public::HomesController < ApplicationController
  def top
    @posts = Post.includes(:user, images_attachments: :blob).order(created_at: :desc).page(params[:page]).per(30)
  end

  def about
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(25)
    @keyword = params[:keyword]
    @category_id = params[:category_id]
    @posts = Post.all
                 .search_by_keyword(@keyword)
                 .search_by_category(@category_id)
                 .includes(:user, :caegory)
                 .order(created_at: :desc)
  end
end
