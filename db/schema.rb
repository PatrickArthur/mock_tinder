# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_21_165753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "picture_id"
    t.boolean "like_object"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_likes_on_picture_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "file"
    t.text "description"
    t.bigint "user_id"
    t.datetime "viewed_at"
    t.index ["user_id"], name: "index_pictures_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "viewed_photos", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "picture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_viewed_photos_on_picture_id"
    t.index ["user_id"], name: "index_viewed_photos_on_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "picture_id"
    t.boolean "vote", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_votes_on_picture_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "viewed_photos", "pictures"
  add_foreign_key "viewed_photos", "users"
end
