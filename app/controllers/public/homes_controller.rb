class Public::HomesController < ApplicationController
  def top
    if user_signed_in?
      redirect_to mypage_path and return
    end
    @latest_posts = Post.order(created_at: :desc).limit(6)
  end

  def about
  end
end
