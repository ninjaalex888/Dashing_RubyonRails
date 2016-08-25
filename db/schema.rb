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

ActiveRecord::Schema.define(version: 20160809221133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dashboards", force: true do |t|
    t.string  "release"
    t.text    "layoutDash"
    t.integer "user_id"
    t.boolean "pub"
  end

  create_table "users", force: true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "login"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "widget_templates", force: true do |t|
    t.string "title",        limit: 32, null: false
    t.text   "moreinfo"
    t.text   "jql"
    t.text   "datatext"
    t.text   "timelinedata"
    t.text   "dateend"
    t.text   "jobname"
    t.text   "filterby"
    t.string "widget_type"
  end

  create_table "widget_types", force: true do |t|
    t.text   "widget_type"
    t.string "widget_type_html", limit: 32
  end

  create_table "widgets", force: true do |t|
    t.string  "title",             limit: 32, null: false
    t.text    "moreinfo"
    t.text    "jql"
    t.string  "releaseversion"
    t.string  "releasebranch"
    t.text    "datatext"
    t.text    "timelinedata"
    t.text    "dateend"
    t.text    "jobname"
    t.text    "filterby"
    t.integer "dashboard_id"
    t.integer "widget_typeid"
    t.integer "widget_templateid"
  end

end
