class Public::HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:top]
  
  def top
    @posts = Post.includes(:user, images_attachments: :blob).order(created_at: :desc).page(params[:page]).per(30)
  end

  def about
    
    @keyword = params[:keyword]
    @category_id = params[:category_id]
    @posts = Post.all
                 .includes(:user, :category, images_attachments: :blob)
                 .order(created_at: :desc)
                 .page(params[:page])
                 .per(25)
  end
end
