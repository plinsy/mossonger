# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_01_104242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "aliens", force: :cascade do |t|
    t.bigint "space_id", null: false
    t.string "muteable_type"
    t.bigint "muteable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["muteable_type", "muteable_id"], name: "index_aliens_on_muteable_type_and_muteable_id"
    t.index ["space_id"], name: "index_aliens_on_space_id"
  end

  create_table "blacklists", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_blacklists_on_admin_id"
  end

  create_table "chat_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "active_status", default: false, null: false
    t.boolean "enable_sounds", default: false, null: false
    t.boolean "enable_notifications", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_chat_settings_on_user_id"
  end

  create_table "condemneds", force: :cascade do |t|
    t.bigint "blacklist_id", null: false
    t.string "blockable_type"
    t.bigint "blockable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["blacklist_id"], name: "index_condemneds_on_blacklist_id"
    t.index ["blockable_type", "blockable_id"], name: "index_condemneds_on_blockable_type_and_blockable_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.string "name", null: false
    t.boolean "receive_notifications_for_messages", default: true, null: false
    t.boolean "receive_notifications_for_reactions", default: true, null: false
    t.integer "max_users", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_conversations_on_admin_id"
  end

  create_table "dropboxes", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_dropboxes_on_admin_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "friend_id", null: false
    t.boolean "is_accepted", default: false, null: false
    t.boolean "is_paused", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["sender_id"], name: "index_friendships_on_sender_id"
  end

  create_table "hiding_places", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_hiding_places_on_admin_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.bigint "guest_id", null: false
    t.text "message"
    t.boolean "is_accepted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_invitations_on_conversation_id"
    t.index ["guest_id"], name: "index_invitations_on_guest_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "conversation_id", null: false
    t.string "messageable_type"
    t.bigint "messageable_id"
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["messageable_type", "messageable_id"], name: "index_messages_on_messageable_type_and_messageable_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "nicknames", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_nicknames_on_conversation_id"
    t.index ["user_id"], name: "index_nicknames_on_user_id"
  end

  create_table "readings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "conversation_id", null: false
    t.bigint "message_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_readings_on_conversation_id"
    t.index ["message_id"], name: "index_readings_on_message_id"
    t.index ["user_id"], name: "index_readings_on_user_id"
  end

  create_table "secrets", force: :cascade do |t|
    t.bigint "hiding_place_id", null: false
    t.string "hideable_type"
    t.bigint "hideable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hideable_type", "hideable_id"], name: "index_secrets_on_hideable_type_and_hideable_id"
    t.index ["hiding_place_id"], name: "index_secrets_on_hiding_place_id"
  end

  create_table "spaces", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_spaces_on_admin_id"
  end

  create_table "trashes", force: :cascade do |t|
    t.bigint "dropbox_id", null: false
    t.string "trashable_type"
    t.bigint "trashable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dropbox_id"], name: "index_trashes_on_dropbox_id"
    t.index ["trashable_type", "trashable_id"], name: "index_trashes_on_trashable_type_and_trashable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone_number", null: false
    t.boolean "is_online", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "aliens", "spaces"
  add_foreign_key "chat_settings", "users"
  add_foreign_key "condemneds", "blacklists"
  add_foreign_key "invitations", "conversations"
  add_foreign_key "messages", "conversations"
  add_foreign_key "nicknames", "conversations"
  add_foreign_key "nicknames", "users"
  add_foreign_key "readings", "conversations"
  add_foreign_key "readings", "messages"
  add_foreign_key "readings", "users"
  add_foreign_key "secrets", "hiding_places"
  add_foreign_key "trashes", "dropboxes"
end
