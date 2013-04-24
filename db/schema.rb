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

ActiveRecord::Schema.define(:version => 20130424162302) do

  create_table "admins", :force => true do |t|
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

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

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "iso_code_2"
    t.string   "iso_code_3"
    t.string   "address_format"
    t.string   "postcode"
    t.integer  "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "h1bemp_fillings", :force => true do |t|
    t.integer  "h1bemp_id"
    t.string   "filingType"
    t.string   "filingYear"
    t.string   "filingStatus"
    t.string   "filingCount"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "h1bemp_fillings", ["h1bemp_id"], :name => "index_h1bemp_fillings_on_h1bemp_id"

  create_table "h1bemp_topjobs", :force => true do |t|
    t.integer  "h1bemp_id"
    t.string   "employerTitle"
    t.string   "totalCount"
    t.string   "avgSalary"
    t.string   "flag"
    t.string   "rn"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "h1bemp_topjobs", ["h1bemp_id"], :name => "index_h1bemp_topjobs_on_h1bemp_id"

  create_table "h1bemps", :force => true do |t|
    t.string   "employerName"
    t.string   "empAddress"
    t.string   "empCity"
    t.string   "empState"
    t.string   "empZip"
    t.string   "h1BTotalApplied"
    t.string   "h1TotalDenied"
    t.string   "h1bApprovalRate"
    t.string   "prevh1Count"
    t.string   "gcTotalApplied"
    t.string   "gcTotalDenied"
    t.string   "gcApprovalRate"
    t.string   "prevgcCount"
    t.string   "prevh1Flag"
    t.string   "prevGCFlag"
    t.string   "h1bARateFlag"
    t.string   "gcARateFlag"
    t.string   "everifiedFlag"
    t.string   "Workforcesize"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "jobseeker_jobs", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "transfer"
    t.integer  "status"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "jobseeker_jobs", ["user_id"], :name => "index_jobseeker_jobs_on_user_id"

  create_table "jobseeker_mentors", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "support"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "jobseeker_mentors", ["user_id"], :name => "index_jobseeker_mentors_on_user_id"

  create_table "jobseeker_trainings", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "status"
    t.integer  "transfer"
    t.string   "technology"
    t.integer  "instruction_mod"
    t.integer  "accomodation"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "jobseeker_trainings", ["user_id"], :name => "index_jobseeker_trainings_on_user_id"

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "post_jobs", :force => true do |t|
    t.integer  "user_id"
    t.string   "job_title"
    t.integer  "job_type"
    t.string   "job_city"
    t.string   "job_state"
    t.string   "job_duration"
    t.text     "job_description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "post_jobs", ["user_id"], :name => "index_post_jobs_on_user_id"

  create_table "post_mentors", :force => true do |t|
    t.integer  "user_id"
    t.string   "job_title"
    t.string   "job_interview"
    t.text     "job_description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "post_mentors", ["user_id"], :name => "index_post_mentors_on_user_id"

  create_table "post_trainings", :force => true do |t|
    t.integer  "user_id"
    t.string   "job_title"
    t.integer  "job_technology"
    t.integer  "job_instruction"
    t.string   "job_placement"
    t.string   "job_accomodation"
    t.string   "job_city"
    t.string   "job_state"
    t.string   "job_duration"
    t.text     "job_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "post_trainings", ["user_id"], :name => "index_post_trainings_on_user_id"

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "is_read",                       :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "skill_lists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills", :force => true do |t|
    t.integer  "skill_list_id"
    t.integer  "skillable_id"
    t.string   "skillable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "skills", ["skill_list_id"], :name => "index_skills_on_skill_list_id"

  create_table "upload_databases", :force => true do |t|
    t.string   "table_name"
    t.text     "data_content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "user_name"
    t.string   "account_type"
    t.string   "immigration_status"
    t.integer  "country_id"
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
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "work_authorizations", :force => true do |t|
    t.integer  "post_job_id"
    t.integer  "workauthorization_index"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "work_authorizations", ["post_job_id"], :name => "index_work_authorizations_on_post_job_id"

end
