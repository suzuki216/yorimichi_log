class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :update, :destroy]

  def show
    
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: @user.is_active ? "アカウントを利用再開しました。" : "アカウントを利用停止しました。"
    else
      render :show, alert: "更新に失敗しました"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_root_path, notice: "ユーザーを削除しました"
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:is_active)
  end
end