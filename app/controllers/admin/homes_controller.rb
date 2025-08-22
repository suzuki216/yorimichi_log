class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @users = User.where.not(email: 'guest@example.com').order(created_at: :desc).page(params[:page])
  end
end
