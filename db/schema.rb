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

ActiveRecord::Schema.define(:version => 20130308173508) do

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
