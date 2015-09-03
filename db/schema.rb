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

ActiveRecord::Schema.define(version: 20150902065615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.text     "client_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "client_address"
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "currency_name"
    t.string   "currency_symbol"
    t.string   "country"
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "employees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.text     "project_name"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "client_id"
    t.text     "project_description"
    t.string   "contact_person"
    t.string   "contact_mail"
    t.integer  "contact_phone",       limit: 8
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role_name"
    t.float    "rate"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "role_description"
    t.integer  "currency_id"
    t.integer  "currencies_id"
    t.integer  "project_id"
    t.integer  "projects_id"
  end

  add_index "roles", ["currencies_id"], name: "index_roles_on_currencies_id", using: :btree
  add_index "roles", ["projects_id"], name: "index_roles_on_projects_id", using: :btree

  create_table "timesheets", force: :cascade do |t|
    t.text     "client"
    t.text     "project"
    t.text     "task"
    t.date     "timesheetdate"
    t.text     "comments"
    t.integer  "employee_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "is_billed"
    t.float    "hours"
    t.string   "role"
    t.float    "rate"
    t.string   "workspace"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "email"
  end

  add_foreign_key "projects", "clients"
  add_foreign_key "roles", "currencies"
  add_foreign_key "roles", "projects"
end
