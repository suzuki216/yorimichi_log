class DropPostImagesTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :post_images, if_exists: true
  end

  def down
    create_table :post_images do |t|
      t.integer :post_id, null: false
      t.string :image
      t.timestamps
    end

    add_index :post_images, :post_id
  end
end
