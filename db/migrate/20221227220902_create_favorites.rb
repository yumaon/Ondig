class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.integer :public_user_id
      t.integer :artist_user_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
