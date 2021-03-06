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

ActiveRecord::Schema.define(version: 20150725004725) do

  create_table "cards", force: :cascade do |t|
    t.integer  "deck_id",    null: false
    t.text     "question",   null: false
    t.text     "answer",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cards", ["answer"], name: "index_cards_on_answer"
  add_index "cards", ["deck_id"], name: "index_cards_on_deck_id"
  add_index "cards", ["question"], name: "index_cards_on_question"

  create_table "comments", force: :cascade do |t|
    t.text     "body",              null: false
    t.integer  "post_id",           null: false
    t.integer  "user_id",           null: false
    t.integer  "parent_comment_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"

  create_table "deck_shares", force: :cascade do |t|
    t.integer  "deck_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "deck_shares", ["deck_id", "user_id"], name: "index_deck_shares_on_deck_id_and_user_id", unique: true

  create_table "decks", force: :cascade do |t|
    t.integer  "owner_id",                   null: false
    t.string   "title",                      null: false
    t.integer  "course_id"
    t.boolean  "public",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "description"
  end

  add_index "decks", ["owner_id"], name: "index_decks_on_owner_id"
  add_index "decks", ["title"], name: "index_decks_on_title"

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id",   null: false
    t.integer  "receiver_id", null: false
    t.string   "subject"
    t.text     "body",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id"
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id"

  create_table "post_subs", force: :cascade do |t|
    t.integer  "sub_id",     null: false
    t.integer  "post_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_subs", ["post_id", "sub_id"], name: "index_post_subs_on_post_id_and_sub_id", unique: true
  add_index "post_subs", ["post_id"], name: "index_post_subs_on_post_id"
  add_index "post_subs", ["sub_id"], name: "index_post_subs_on_sub_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "url"
    t.text     "content"
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "card_id",                   null: false
    t.integer  "quality",                   null: false
    t.float    "e_factor",    default: 2.3, null: false
    t.integer  "next_rep",                  null: false
    t.integer  "repetitions", default: 0,   null: false
    t.float    "last_passed",               null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "responses", ["card_id"], name: "index_responses_on_card_id"
  add_index "responses", ["user_id"], name: "index_responses_on_user_id"

  create_table "subs", force: :cascade do |t|
    t.string   "title",        null: false
    t.text     "description"
    t.integer  "moderator_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "image_url"
  end

  add_index "subs", ["image_url"], name: "index_subs_on_image_url"
  add_index "subs", ["title", "moderator_id"], name: "index_subs_on_title_and_moderator_id", unique: true

  create_table "user_votes", force: :cascade do |t|
    t.integer  "value",        null: false
    t.integer  "user_id",      null: false
    t.integer  "votable_id",   null: false
    t.string   "votable_type", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "user_votes", ["user_id", "votable_id", "votable_type"], name: "index_user_votes_on_user_id_and_votable_id_and_votable_type", unique: true
  add_index "user_votes", ["votable_id", "votable_type"], name: "index_user_votes_on_votable_id_and_votable_type"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  null: false
    t.string   "password_digest",        null: false
    t.string   "session_token",          null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "password_reset_digest"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
