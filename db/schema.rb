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

ActiveRecord::Schema.define(:version => 20120727095149) do

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

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body",             :default => ""
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "course_sessions", :force => true do |t|
    t.datetime "session_datetime"
    t.decimal  "duration"
    t.string   "duration_type"
    t.text     "location"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "course_id"
    t.text     "description_zh"
    t.text     "description_en"
    t.text     "searchable_description_zh"
    t.string   "title_en"
    t.string   "title_zh"
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
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.string   "image_file_size"
    t.text     "searchable_summary_zh"
    t.text     "searchable_description_zh"
    t.text     "searchable_name_zh"
    t.string   "difficulty"
    t.integer  "category_id"
    t.integer  "owner_id"
    t.datetime "start_date_time"
    t.text     "address"
    t.decimal  "price"
    t.string   "price_type"
    t.string   "state",                     :default => "inactive"
  end

  create_table "email_templates", :force => true do |t|
    t.string   "name"
    t.text     "html"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "text"
  end

  create_table "emails", :force => true do |t|
    t.text     "subject"
    t.string   "to_address"
    t.string   "template_name"
    t.text     "info"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "code"
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "course_id"
    t.integer  "person_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "payment_method"
    t.string   "state"
  end

  create_table "guides", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title_zh"
    t.string   "title_en"
    t.text     "content_zh"
    t.text     "content_en"
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

  create_table "pay_fu_transactions", :force => true do |t|
    t.string   "type"
    t.string   "transaction_id"
    t.string   "transaction_type"
    t.string   "payment_status"
    t.datetime "payment_date"
    t.integer  "gross"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.hstore   "raw_data"
    t.integer  "enrollment_id"
  end

  create_table "people", :force => true do |t|
    t.string   "uid"
    t.string   "username"
    t.string   "token"
    t.string   "secret"
    t.string   "provider"
    t.text     "profile_attributes"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "email_address"
    t.string   "mobile"
    t.string   "name"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "people", ["reset_password_token"], :name => "index_people_on_reset_password_token", :unique => true

  create_table "people_roles", :id => false, :force => true do |t|
    t.integer "person_id"
    t.integer "role_id"
  end

  add_index "people_roles", ["person_id", "role_id"], :name => "index_people_roles_on_person_id_and_role_id"

  create_table "presentations", :force => true do |t|
    t.integer  "page_id"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "person_id"
    t.text     "about"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_content_type"
    t.string   "avatar_file_name"
    t.string   "avatar_file_size"
  end

  create_table "providers", :force => true do |t|
    t.string   "uid"
    t.string   "username"
    t.string   "token"
    t.string   "secret"
    t.string   "provider"
    t.text     "profile_attributes"
    t.string   "email"
    t.integer  "person_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
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
