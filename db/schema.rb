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

ActiveRecord::Schema.define(:version => 20120829174433) do

  create_table "accounts", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "profile_type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "linked_in"
    t.integer  "invited_by_id"
    t.string   "invitation_token"
    t.string   "avatar"
  end

  add_index "accounts", ["confirmation_token"], :name => "index_accounts_on_confirmation_token", :unique => true
  add_index "accounts", ["email"], :name => "index_accounts_on_email", :unique => true
  add_index "accounts", ["reset_password_token"], :name => "index_accounts_on_reset_password_token", :unique => true

  create_table "attachments", :force => true do |t|
    t.integer  "project_id"
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "competitions", :force => true do |t|
    t.string   "competition_name"
    t.datetime "date"
    t.datetime "time"
    t.string   "city"
    t.string   "state"
    t.string   "location"
    t.boolean  "accepting_business_plans", :default => false
    t.string   "prize"
    t.text     "competition_details"
    t.text     "requirements"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "invitations", :force => true do |t|
    t.integer  "project_id"
    t.string   "recipient_email"
    t.string   "invitation_token"
    t.datetime "sent_at"
    t.string   "recipient_name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "account_id"
    t.integer  "project_id"
    t.boolean  "pending",    :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "notifications", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.datetime "date"
    t.boolean  "priority",          :default => false
    t.integer  "notifier_id"
    t.string   "notifier_type"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "notification_type"
    t.datetime "time"
  end

  create_table "projects", :force => true do |t|
    t.string   "business_name"
    t.string   "industry"
    t.string   "city"
    t.string   "state"
    t.text     "business_concept"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "logo"
    t.string   "business_plan"
    t.text     "video_url"
    t.boolean  "published",        :default => false
    t.datetime "published_at"
  end

end
