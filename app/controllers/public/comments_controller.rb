class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if current_user.email == "guest@example.com"
      redirect_to public_post_path(@post), alert: "ゲストユーザーはコメントできません"
      return
    end
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to public_post_path(@post), notice: "コメントを投稿しました"
    else
      @comments = @post.comments.includes(:user)
      render "public/posts/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    if @comment.user == current_user
      @comment.destroy
      redirect_to public_post_path(post), notice: "コメントを削除しました"
    else
      redirect_to public_post_path(post), alert: "削除権限がありません"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
