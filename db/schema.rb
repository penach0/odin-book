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

ActiveRecord::Schema[7.0].define(version: 2023_04_21_082430) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentication_providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_name_on_authentication_providers"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "commenter_id", null: false
    t.bigint "commented_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commented_post_id"], name: "index_comments_on_commented_post_id"
    t.index ["commenter_id"], name: "index_comments_on_commenter_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "friend_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "GREATEST(friend_id, user_id), LEAST(friend_id, user_id)", name: "index_friendships_on_interchangeable_friend_id_and_user_id", unique: true
    t.index "GREATEST(user_id, friend_id), LEAST(user_id, friend_id)", name: "index_friendships_on_interchangeable_and_user_id_friend_id", unique: true
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_posts_on_creator_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.text "bio"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "social_accounts", force: :cascade do |t|
    t.string "token"
    t.string "secret"
    t.bigint "user_id"
    t.bigint "authentication_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_provider_id"], name: "index_social_accounts_on_authentication_provider_id"
    t.index ["user_id"], name: "index_social_accounts_on_user_id"
  end

  create_table "user_authentications", force: :cascade do |t|
    t.string "uid"
    t.string "token"
    t.datetime "token_expires_at"
    t.text "params"
    t.bigint "user_id", null: false
    t.bigint "authentication_providers_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_providers_id"], name: "index_user_authentications_on_authentication_providers_id"
    t.index ["user_id"], name: "index_user_authentications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "posts", column: "commented_post_id"
  add_foreign_key "comments", "users", column: "commenter_id"
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "posts", "users", column: "creator_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "social_accounts", "authentication_providers"
  add_foreign_key "social_accounts", "users"
  add_foreign_key "user_authentications", "authentication_providers", column: "authentication_providers_id"
  add_foreign_key "user_authentications", "users"
end
