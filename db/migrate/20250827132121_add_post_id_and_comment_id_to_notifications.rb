class AddPostIdAndCommentIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :post_id, :integer
    add_column :notifications, :comment_id, :integer
  end
end
