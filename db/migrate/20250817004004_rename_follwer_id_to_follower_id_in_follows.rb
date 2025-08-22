class RenameFollwerIdToFollowerIdInFollows < ActiveRecord::Migration[6.1]
  def change
    rename_column :follows, :follwer_id, :follower_id
  end
end
