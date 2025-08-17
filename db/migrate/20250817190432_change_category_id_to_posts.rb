class ChangeCategoryIdToPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :category_id, true
  end
end
