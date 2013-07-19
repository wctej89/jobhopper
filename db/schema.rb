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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130719041614) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cities", ["id"], :name => "index_cities_on_id"
  add_index "cities", ["latitude"], :name => "index_cities_on_latitude"
  add_index "cities", ["longitude"], :name => "index_cities_on_longitude"

  create_table "job_lists", :force => true do |t|
    t.integer  "list_id"
    t.integer  "job_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.text     "notes",      :default => " "
    t.integer  "status_id"
  end

  add_index "job_lists", ["job_id", "list_id"], :name => "index_job_lists_on_job_id_and_list_id", :unique => true

  create_table "job_tags", :force => true do |t|
    t.integer  "job_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "job_tags", ["id"], :name => "index_job_tags_on_id"
  add_index "job_tags", ["job_id"], :name => "index_job_tags_on_job_id"
  add_index "job_tags", ["tag_id"], :name => "index_job_tags_on_tag_id"

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "email"
    t.string   "company"
    t.string   "source_url"
    t.integer  "angellist_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.float    "lat"
    t.float    "lng"
    t.integer  "city_id"
  end

  add_index "jobs", ["city_id"], :name => "index_jobs_on_city_id"
  add_index "jobs", ["id"], :name => "index_jobs_on_id"
  add_index "jobs", ["name"], :name => "index_jobs_on_name"

  create_table "lists", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "subject"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "job_id"
    t.string   "read"
  end

  create_table "statuses", :force => true do |t|
    t.string   "status"
    t.string   "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "tag_type"
  end

  add_index "tags", ["id"], :name => "index_tags_on_id"
  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "user_tags", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "applied",    :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "location"
    t.text     "bio"
    t.float    "lat"
    t.float    "lng"
  end

  create_table "zips", :force => true do |t|
    t.string "zip_code"
    t.string "url"
  end

end
