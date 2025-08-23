class DropPostImagesTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :post_images
  end

  def down
    create_table :post_images do |t|
      t.references :post, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
