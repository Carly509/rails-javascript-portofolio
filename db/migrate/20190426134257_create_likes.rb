class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :tweet_id
      t.integer :user_id
      t.boolean :like 
      t.timestamps
    end
  end
end
