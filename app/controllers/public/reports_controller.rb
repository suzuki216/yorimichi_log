class Public::ReportsController < ApplicationController
  before_action :check_guest, only: [:create, :destroy]
  def index
    @reports = current_user.reports.includes(:post).order(created_at: :desc).page(params[:page]).per(10)
  end
  def create 
    @post = Post.find(params[:post_id])
    @report = current_user.reports.new(post: @post, reason: report_params[:reason])
    if @report.save
      flash[:notice] = "通報しました。管理者が確認します。"
      redirect_to public_post_path(@post)
    else
      flash[:alert] = "通報に失敗しました: " + @report.errors.full_messages.join(", ")
      redirect_to public_post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @report = current_user.reports.find(params[:id])
    @post = @report.post
    @report.destroy
    flash[:notice] = "通報を取り消しました。"
    redirect_to public_post_path(@post)
  end

  private
  def report_params
    params.require(:report).permit(:reason)
  end

  def check_guest
    if current_user&.guest?
      redirect_to request.referrer || root_path, alert: "ゲストユーザーは操作できません"
    end
  end
end
