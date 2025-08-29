class Public::NotificationsController < ApplicationController
  before_action :check_guest_for_guest_access, only: [:index]
  def index
    @notifications = current_user.passive_notifications.includes(:visitor, :post).order(created_at: :desc)
    
    @notifications.where(checked: false).update_all(checked: true)
  end

  def destroy
    notification = current_user.passive_notifications.find(params[:id])
    notification.destroy
    redirect_to public_notifications_path, notice: "通知を削除しました"
  end

  def destroy_all
    current_user.passive_notifications.destroy_all
    redirect_to public_notifications_path, notice: "全ての通知を削除しました"
  end

  private

  def check_guest_for_guest_access
    if current_user&.guest?
      redirect_to public_homes_about_path, alert: "新規登録してください。"
    end
  end
end
