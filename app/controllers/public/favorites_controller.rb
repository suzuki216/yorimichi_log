class Public::FavoritesController < ApplicationController
  before_action :check_guest, only: [:create, :destroy]
  before_action :check_guest_for_guest_access, only: [:index]
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    if favorite.save
      @post.create_notification_favorite!(current_user)
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy

  end

  def index
    @favorite_posts = current_user.favorite_posts.includes(:user).order(created_at: :desc).page(params[:page]).per(9)
  end

  private

  def check_guest
    if current_user&.guest?
      redirect_to request.referrer || root_path, alert: "ゲストユーザーは操作できません"
    end
  end

  def check_guest_for_guest_access
    if current_user&.guest?
      redirect_to public_homes_about_path, alert: "新規登録してください。"
    end
  end
end
