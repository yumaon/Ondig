# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_07_062938) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "artist_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "genre_id"
    t.string "rep_name", null: false
    t.string "rep_name_kana", null: false
    t.string "artist_name", null: false
    t.text "introduction"
    t.integer "activity_location", null: false
    t.string "youtube_url"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_artist_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_artist_users_on_reset_password_token", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "public_user_id"
    t.integer "artist_user_id"
    t.integer "topic_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "artist_user_id", null: false
    t.string "name", null: false
    t.text "introduction", null: false
    t.integer "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "joins", force: :cascade do |t|
    t.integer "artist_user_id"
    t.integer "public_user_id"
    t.integer "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_user_id"], name: "index_joins_on_artist_user_id"
    t.index ["public_user_id"], name: "index_joins_on_public_user_id"
    t.index ["room_id"], name: "index_joins_on_room_id"
  end

  create_table "live_schedules", force: :cascade do |t|
    t.integer "artist_user_id", null: false
    t.string "name", null: false
    t.datetime "schedule_date", null: false
    t.integer "price", null: false
    t.string "location", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "artist_user_id"
    t.integer "public_user_id"
    t.integer "room_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_user_id"], name: "index_messages_on_artist_user_id"
    t.index ["public_user_id"], name: "index_messages_on_public_user_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "public_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.string "nickname", null: false
    t.text "introduction"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_public_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_public_users_on_reset_password_token", unique: true
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "artist_follower_id"
    t.integer "artist_followed_id"
    t.integer "public_follower_id"
    t.integer "public_followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "topic_comments", force: :cascade do |t|
    t.integer "topic_id", null: false
    t.integer "public_user_id"
    t.integer "artist_user_id"
    t.text "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "topic_tags", force: :cascade do |t|
    t.integer "topic_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_topic_tags_on_tag_id"
    t.index ["topic_id", "tag_id"], name: "index_topic_tags_on_topic_id_and_tag_id", unique: true
    t.index ["topic_id"], name: "index_topic_tags_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.integer "artist_user_id", null: false
    t.text "body", null: false
    t.string "youtube_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "joins", "artist_users"
  add_foreign_key "joins", "public_users"
  add_foreign_key "joins", "rooms"
  add_foreign_key "messages", "artist_users"
  add_foreign_key "messages", "public_users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "topic_tags", "tags"
  add_foreign_key "topic_tags", "topics"
end
