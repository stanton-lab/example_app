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

ActiveRecord::Schema.define(version: 20160607122752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avatars", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "avatarable_id"
    t.string   "avatarable_type"
  end

  add_index "avatars", ["avatarable_type", "avatarable_id"], name: "index_avatars_on_avatarable_type_and_avatarable_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "company",    default: "",    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_deleted", default: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.boolean  "is_deleted",       default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "manager_id"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree

  create_table "contact_people", force: :cascade do |t|
    t.string   "email",      default: "",    null: false
    t.string   "full_name",  default: "",    null: false
    t.text     "phones",                                  array: true
    t.integer  "client_id"
    t.boolean  "is_deleted", default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "contact_people", ["client_id"], name: "index_contact_people_on_client_id", using: :btree

  create_table "currencies", force: :cascade do |t|
    t.string   "name"
    t.decimal  "default",    precision: 8, scale: 2
    t.boolean  "is_active",                          default: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "currencies_periods", force: :cascade do |t|
    t.integer  "period_id"
    t.integer  "currency_id"
    t.decimal  "value",       precision: 8, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "currencies_periods", ["currency_id"], name: "index_currencies_periods_on_currency_id", using: :btree
  add_index "currencies_periods", ["period_id"], name: "index_currencies_periods_on_period_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_deleted", default: false
  end

  create_table "managers", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "is_deleted",             default: false
    t.string   "full_name"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "birthday"
    t.datetime "worked_at"
    t.string   "skype"
    t.integer  "department_id"
    t.integer  "status",                 default: 0
  end

  add_index "managers", ["email"], name: "index_managers_on_email", unique: true, using: :btree
  add_index "managers", ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true, using: :btree

  create_table "managers_roles", id: false, force: :cascade do |t|
    t.integer "manager_id"
    t.integer "role_id"
  end

  add_index "managers_roles", ["manager_id", "role_id"], name: "index_managers_roles_on_manager_id_and_role_id", using: :btree

  create_table "periods", force: :cascade do |t|
    t.date     "starts_at"
    t.date     "ends_at"
    t.boolean  "is_deleted", default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "phones", force: :cascade do |t|
    t.string   "phone"
    t.integer  "phonable_id"
    t.string   "phonable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "phones", ["phonable_id"], name: "index_phones_on_phonable_id", using: :btree

  create_table "project_clients", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "project_clients", ["client_id"], name: "index_project_clients_on_client_id", using: :btree
  add_index "project_clients", ["project_id"], name: "index_project_clients_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_deleted", default: false
    t.boolean  "is_active",  default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "manager_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "works", force: :cascade do |t|
    t.string   "name"
    t.integer  "department_id"
    t.boolean  "is_iterative",  default: false
    t.boolean  "is_deleted",    default: false
    t.integer  "percent"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "works", ["department_id"], name: "index_works_on_department_id", using: :btree

end
