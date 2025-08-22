class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :follwer_id
      t.integer :followed_id

      t.timestamps
    end
  end
end
