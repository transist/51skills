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

ActiveRecord::Schema.define(:version => 20120510010233) do

  create_table "mercury_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title_en"
    t.string   "title_zh"
    t.text     "content_en",  :limit => 255
    t.text     "content_zh",  :limit => 255
    t.string   "slug"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "deleteable",                 :default => true
    t.boolean  "root",                       :default => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.boolean  "published",                  :default => false
    t.boolean  "nav",                        :default => false
    t.boolean  "include_nav",                :default => true
    t.boolean  "sidebar",                    :default => true
    t.boolean  "header",                     :default => true
  end

  create_table "people", :force => true do |t|
    t.string   "uid"
    t.string   "username"
    t.string   "token"
    t.string   "secret"
    t.string   "provider"
    t.text     "profile_attributes"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "email"
    t.string   "mobile"
    t.string   "name"
  end

  create_table "presentations", :force => true do |t|
    t.integer  "page_id"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "slides", :force => true do |t|
    t.integer  "presentation_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
