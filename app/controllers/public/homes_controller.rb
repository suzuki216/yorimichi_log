class Public::HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:top]
  
  def top
    @posts = Post.includes(:user, images_attachments: :blob).order(created_at: :desc).page(params[:page]).per(30)
  end

  def about
    @keyword = params[:keyword]
    @category_name = params[:category_name]
    @posts = Post.all
    if @keyword.present?
      normalized_keyword = @keyword.tr('０-９', '0-9')

      @posts = @posts.where(
        "REPLACE(title,'０','0') LIKE :kw OR REPLACE(title,'１','1') LIKE :kw OR REPLACE(title,'２','2') LIKE :kw OR REPLACE(title,'３','3') LIKE :kw OR REPLACE(title,'４','4') LIKE :kw OR REPLACE(title,'５','5') LIKE :kw OR REPLACE(title,'６','6') LIKE :kw OR REPLACE(title,'７','7') LIKE :kw OR REPLACE(title,'８','8') LIKE :kw OR REPLACE(title,'９','9') LIKE :kw
        OR
        REPLACE(body,'０','0') LIKE :kw OR REPLACE(body,'１','1') LIKE :kw OR REPLACE(body,'２','2') LIKE :kw OR REPLACE(body,'３','3') LIKE :kw OR REPLACE(body,'４','4') LIKE :kw OR REPLACE(body,'５','5') LIKE :kw OR REPLACE(body,'６','6') LIKE :kw OR REPLACE(body,'７','7') LIKE :kw OR REPLACE(body,'８','8') LIKE :kw OR REPLACE(body,'９','9') LIKE :kw",
        kw: "%#{normalized_keyword}%"
      )
    end

    if @category_name.present?
      @posts = @posts.joins(:category)
                     .where("categories.name LIKE ?", "%#{@category_name}%")
    end
    @posts = @posts.includes(:user, :category, images_attachments: :blob)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(25)
  end
  
end
