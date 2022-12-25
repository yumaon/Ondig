class CreateTopicComments < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_comments do |t|

      t.integer :topic_id, null: false
      t.integer :public_user_id
      t.integer :artist_user_id
      t.text :comment, null: false

      t.timestamps
    end
  end
end
