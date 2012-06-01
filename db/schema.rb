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

ActiveRecord::Schema.define(:version => 20120601080209) do

  create_table "categories", :force => true do |t|
    t.string   "name_en"
    t.string   "name_zh"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  create_table "course_sessions", :force => true do |t|
    t.datetime "session_datetime"
    t.decimal  "duration"
    t.string   "duration_type"
    t.text     "location"
    t.text     "descrption"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name_en"
    t.string   "name_zh"
    t.text     "description_en"
    t.text     "description_zh"
    t.text     "summary_en"
    t.text     "summary_zh"
    t.string   "weibo"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "github"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.string   "image_file_size"
    t.text     "searchable_summary_zh"
    t.text     "searchable_description_zh"
    t.text     "searchable_name_zh"
    t.string   "difficulty"
    t.integer  "category_id"
    t.integer  "owner_id"
  end

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
    t.text     "content_en"
    t.text     "content_zh"
    t.string   "slug"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "deleteable",  :default => true
    t.boolean  "root",        :default => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth",       :default => 1
    t.boolean  "published",   :default => false
    t.boolean  "nav",         :default => false
    t.boolean  "include_nav", :default => true
    t.boolean  "sidebar",     :default => true
    t.boolean  "header",      :default => true
    t.boolean  "hidden",      :default => true
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

  create_table "people_roles", :id => false, :force => true do |t|
    t.integer "person_id"
    t.integer "role_id"
  end

  add_index "people_roles", ["person_id", "role_id"], :name => "index_people_roles_on_person_id_and_role_id"

  create_table "photos", :force => true do |t|
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "comment_en"
    t.text     "comment_zh"
    t.string   "slug"
    t.string   "download_url"
  end

  create_table "presentations", :force => true do |t|
    t.integer  "page_id"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "slides", :force => true do |t|
    t.integer  "presentation_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "watches", :force => true do |t|
    t.integer  "person_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
