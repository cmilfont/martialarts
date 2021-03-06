# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131006203424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_techniques", force: true do |t|
    t.integer "category_id"
    t.integer "technique_id"
  end

  create_table "martialart_techniques", force: true do |t|
    t.integer  "martialart_id"
    t.integer  "technique_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "martialarts", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "martialarts_techniques", force: true do |t|
    t.integer "martialart_id"
    t.integer "technique_id"
  end

  create_table "tag_techniques", force: true do |t|
    t.integer  "tag_id"
    t.integer  "technique_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_techniques", ["tag_id"], name: "index_tag_techniques_on_tag_id", using: :btree
  add_index "tag_techniques", ["technique_id"], name: "index_tag_techniques_on_technique_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "techniques", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "nickname"
    t.string   "location"
    t.string   "link_facebook"
    t.string   "locale"
    t.string   "facebook_id"
    t.string   "picture_facebook_square"
    t.string   "picture_facebook_small"
    t.string   "picture_facebook_normal"
    t.string   "picture_facebook_large"
    t.string   "token_facebook"
    t.string   "provider"
    t.string   "uid"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.integer  "technique_id"
    t.integer  "user_id"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
