class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      t.integer :artist_follower_id
      t.integer :artist_followed_id
      t.integer :public_follower_id
      t.integer :public_followed_id

      t.timestamps
    end
  end
end
