class Admin::ReportsController < ApplicationController
  def index
    @posts = Post.joins(:reports).includes(:reports, :user).distinct.order('reports.created_at DESC').page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:post_id])
    @reports = @post.reports.includes(:user).order(created_at: :desc)
  end

end
