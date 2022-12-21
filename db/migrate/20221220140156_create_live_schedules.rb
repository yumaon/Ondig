class CreateLiveSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :live_schedules do |t|

      t.integer :artist_user_id, null: false
      t.string :name, null: false
      t.datetime :schedule_date, null: false
      t.integer :price, null: false
      t.string :location, null: false

      t.timestamps
    end
  end
end
