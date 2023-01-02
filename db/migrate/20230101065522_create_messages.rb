class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :artist_user, null: true, foreign_key: true
      t.references :public_user, null: true, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
