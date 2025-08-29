class Public::FollowsController < ApplicationController
  before_action :check_guest, only: [:create, :destroy]
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    user.active_notifications.create(
      visitor_id: current_user.id,
      visited_id: user.id,
      action: "follow"
    )
    redirect_to public_user_path(user), notice: "#{user.full_name}さんをフォローしました"
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to public_user_path(user), notice: "#{user.full_name}さんのフォローを解除しました"
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
    @posts = Post.where(user_id: @user.followings.select(:id)).order(create_at: :desc).page(params[:page]).per(9)
  end
  
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
    @posts = Post.where(user_id: @user.followers.select(:id)).order(create_at: :desc).page(params[:page]).per(9)
  end

  private

  def check_guest
    if current_user&.guest?
      redirect_to request.referrer || root_path, alert: "ゲストユーザーは操作できません"
    end
  end
end
