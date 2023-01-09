class CreateTopicTags < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_tags do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    # 同じタグを2回保存するのを出来ないようにするための記述
    add_index :topic_tags, [:topic_id, :tag_id], unique: true
  end
end
