class Admin::HomesController < ApplicationController
  def top
    @users = User.order(created_at: :desc).limit(10)
  end
end
