class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|

      t.integer :artist_user_id, null: false
      t.text :body, null: false
      t.string :youtube_url

      t.timestamps
    end
  end
end
