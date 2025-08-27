class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :guest_cannot_access, only: [:mypage, :edit, :update, :destroy]
  def mypage
    @user = current_user
    @posts = current_user.posts.order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
  end

  def edit
    
  end
  
  def update
    @user = current_user
    account_update_params = user_params

    if account_update_params[:password].blank?
      account_update_params.delete(:password)
      account_update_params.delete(:password_confirmation)
      account_update_params[:email] ||= @user.email
    end

    if account_update_params[:password].blank?
      if @user.update_without_password(account_update_params)
        redirect_to public_mypage_path, notice: "プロフィールを更新しました"
      else
        flash.now[:alert] = "更新に失敗しました"
        render :edit
      end
    else

      if @user.update(account_update_params)
        redirect_to public_mypage_path, notice: "プロフィールを更新しました"
      else
        flash.now[:alert] = "更新に失敗しました"
        render :edit
      end
    end
  end
  def destroy
    @user.destroy
    sign_out @user
    redirect_to new_user_registration_path, notice: "退会しました"
  end

  def search
    @user_keyword = params[:user_keyword]

    @users = if @user_keyword.present?
      User.where("last_name LIKE ? OR first_name LIKE ?", "%#{@user_keyword}%", "%#{@user_keyword}%")
          .includes(posts: [images_attachments: :blob])
          .order(created_at: :desc)
    else
      []
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    return if current_user.guest?
    redirect_to public_user_path(current_user), alert: "権限がありません" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :password, :password_confirmation, :image, :introduction)
  end

  def guest_cannot_access
    if current_user&.guest?
      redirect_to about_path, alert: "新規登録してください。"
    end
  end
end
