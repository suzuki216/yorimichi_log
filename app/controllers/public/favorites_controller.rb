class Public::FavoritesController < ApplicationController
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
end
