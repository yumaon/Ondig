class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.integer :artist_user_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
