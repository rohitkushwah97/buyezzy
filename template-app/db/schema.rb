# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2025_05_08_141518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "account_categories", force: :cascade do |t|
    t.integer "account_id"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "account_groups_account_groups", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "account_groups_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_groups_group_id"], name: "index_account_groups_account_groups_on_account_groups_group_id"
    t.index ["account_id"], name: "index_account_groups_account_groups_on_account_id"
  end

  create_table "account_groups_groups", force: :cascade do |t|
    t.string "name"
    t.jsonb "settings"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "full_phone_number"
    t.integer "country_code"
    t.bigint "phone_number"
    t.string "email"
    t.boolean "activated", default: false, null: false
    t.text "device_id", default: [], array: true
    t.text "unique_auth_id"
    t.string "password_digest"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_name"
    t.string "platform"
    t.string "user_type"
    t.integer "app_language_id"
    t.datetime "last_visit_at"
    t.boolean "is_blacklisted", default: false
    t.date "suspend_until"
    t.integer "status", default: 0, null: false
    t.integer "role_id"
    t.string "full_name"
    t.integer "gender"
    t.date "date_of_birth"
    t.integer "age"
    t.boolean "terms_accepted", default: false, null: false
    t.integer "emirates_id"
    t.string "expire_tokens", default: [], array: true
    t.string "token"
    t.string "update_by"
    t.integer "career_count", default: 0
    t.string "country_flag"
    t.string "invalid_tokens", default: [], array: true
    t.index ["is_blacklisted"], name: "index_accounts_on_is_blacklisted"
  end

  create_table "accounts_bx_block_navmenu_internships", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "internship_id", null: false
    t.string "status", default: "pending"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "is_withdraw", default: false
    t.boolean "is_terminate", default: false
    t.index ["account_id", "internship_id"], name: "index_acc_internship_on_account_id", unique: true
    t.index ["internship_id", "account_id"], name: "index_internship_acc_on_internship_id", unique: true
    t.index ["status"], name: "index_accounts_bx_block_navmenu_internships_on_status"
  end

  create_table "accounts_chats", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "chat_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "muted", default: false
    t.index ["account_id"], name: "index_accounts_chats_on_account_id"
    t.index ["chat_id"], name: "index_accounts_chats_on_chat_id"
  end

  create_table "achievements", force: :cascade do |t|
    t.string "title"
    t.date "achievement_date"
    t.text "detail"
    t.string "url"
    t.integer "profile_bio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.boolean "default_image", default: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "addressables", force: :cascade do |t|
    t.bigint "shipment_id", null: false
    t.text "address"
    t.text "address2"
    t.string "city"
    t.string "country"
    t.string "email"
    t.string "name"
    t.string "phone"
    t.text "instructions"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipment_id"], name: "index_addressables_on_shipment_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.integer "addressble_id"
    t.string "addressble_type"
    t.integer "address_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "admin_notifications", force: :cascade do |t|
    t.string "message", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "attachment_id"
    t.index ["attachment_id"], name: "index_admin_notifications_on_attachment_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "applied_jobs", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "job_id"
    t.integer "company_page_id"
    t.string "applied_job_title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "pending"
    t.string "preffered_location"
    t.string "applicant_status", default: "new_applicant"
    t.string "preferred_timing"
    t.string "answer", default: [], array: true
    t.string "question", default: [], array: true
  end

  create_table "arrival_windows", force: :cascade do |t|
    t.datetime "begin_at"
    t.datetime "end_at"
    t.boolean "exclude_begin", default: true
    t.boolean "exclude_end", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "addressable_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "colour"
    t.string "layout"
    t.string "page_size"
    t.string "scale"
    t.string "print_sides"
    t.integer "print_pages_from"
    t.integer "print_pages_to"
    t.integer "total_pages"
    t.boolean "is_expired", default: false
    t.integer "total_attachment_pages"
    t.string "pdf_url"
    t.boolean "is_printed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "files"
    t.integer "status"
    t.index ["account_id"], name: "index_attachments_on_account_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "service_provider_id"
    t.string "start_time"
    t.string "end_time"
    t.string "unavailable_start_time"
    t.string "unavailable_end_time"
    t.string "availability_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "timeslots"
    t.integer "available_slots_count"
    t.index ["service_provider_id"], name: "index_availabilities_on_service_provider_id"
  end

  create_table "black_list_users", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_black_list_users_on_account_id"
  end

  create_table "block_users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "current_user_id"
    t.bigint "account_id"
    t.index ["account_id"], name: "index_block_users_on_account_id"
    t.index ["current_user_id"], name: "index_block_users_on_current_user_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "currency", default: 0
  end

  create_table "business_user_generic_answers", force: :cascade do |t|
    t.bigint "business_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "answer"
    t.bigint "internship_id"
    t.bigint "business_user_generic_question_id"
  end

  create_table "business_user_generic_questions", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "question"
    t.string "title"
    t.string "hint"
  end

  create_table "bx_block_addfriends_connections", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "receipient_id"
    t.string "status", default: "pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_bx_block_addfriends_connections_on_account_id"
  end

  create_table "bx_block_appointment_management_booked_slots", force: :cascade do |t|
    t.bigint "order_id"
    t.string "start_time"
    t.string "end_time"
    t.bigint "service_provider_id"
    t.date "booking_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bx_block_attachment_file_attachments", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "colour"
    t.string "layout"
    t.string "page_size"
    t.string "scale"
    t.string "print_sides"
    t.integer "print_pages_from"
    t.integer "print_pages_to"
    t.integer "total_pages"
    t.boolean "is_expired", default: false
    t.integer "total_attachment_pages"
    t.string "pdf_url"
    t.boolean "is_printed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_bx_block_attachment_file_attachments_on_account_id"
  end

  create_table "bx_block_content_management_content_managments", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "status"
    t.float "price"
    t.integer "user_type"
    t.string "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "publish_date"
  end

  create_table "bx_block_content_moderation_contents", force: :cascade do |t|
    t.text "text_content"
    t.boolean "is_text_approved"
    t.boolean "is_image_approved"
    t.boolean "is_active"
    t.bigint "created_by"
    t.string "updated_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bx_block_contentflag_contents", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "account_id", null: false
    t.integer "flag_category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved", default: false
    t.index ["account_id"], name: "index_bx_block_contentflag_contents_on_account_id"
    t.index ["post_id"], name: "index_bx_block_contentflag_contents_on_post_id"
  end

  create_table "bx_block_contentflag_flag_categories", force: :cascade do |t|
    t.string "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bx_block_contentflag_flag_comments", force: :cascade do |t|
    t.integer "account_id"
    t.integer "post_id"
    t.integer "comment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved", default: false
    t.bigint "flag_category_id"
  end

  create_table "bx_block_help_centre_faqs", force: :cascade do |t|
    t.string "question"
    t.text "answer"
    t.string "created_for"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bx_block_inapppurchasing_inapp_subscriptions", force: :cascade do |t|
    t.string "transaction_id"
    t.string "platform"
    t.string "receipt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bx_block_joblisting_jobs", force: :cascade do |t|
    t.string "job_title"
    t.boolean "remote_job", default: true
    t.string "location"
    t.integer "employment_type_id"
    t.integer "total_inteview_rounds"
    t.integer "skill_id", default: [], array: true
    t.text "job_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_page_id"
    t.string "other_skills", default: [], array: true
    t.decimal "salary", default: "0.0"
    t.string "seniority_level"
    t.string "job_function"
    t.string "question_answer_id", default: [], array: true
    t.string "preffered_location", default: [], array: true
    t.integer "industry_id"
    t.string "addresses", default: [], array: true
    t.string "sub_emplotyment_type"
  end

  create_table "bx_block_like_a_post_restricted_words", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "word"
    t.string "#<ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition"
  end

  create_table "bx_block_navmenu_internships", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "title"
    t.text "description"
    t.decimal "monthly_salary"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "industry_id"
    t.bigint "role_id"
    t.bigint "work_location_id"
    t.bigint "work_schedule_id"
    t.bigint "country_id"
    t.bigint "city_id"
    t.bigint "business_user_id"
    t.integer "status", default: 0
    t.integer "duration", default: 0
    t.integer "educational_statuses", default: [], array: true
    t.datetime "deadline_date"
    t.boolean "is_closed", default: false
    t.index ["business_user_id"], name: "index_bx_block_navmenu_internships_on_business_user_id"
    t.index ["city_id"], name: "index_bx_block_navmenu_internships_on_city_id"
    t.index ["country_id"], name: "index_bx_block_navmenu_internships_on_country_id"
    t.index ["industry_id"], name: "index_bx_block_navmenu_internships_on_industry_id"
    t.index ["monthly_salary"], name: "index_bx_block_navmenu_internships_on_monthly_salary"
    t.index ["role_id"], name: "index_bx_block_navmenu_internships_on_role_id"
    t.index ["start_date"], name: "index_bx_block_navmenu_internships_on_start_date"
    t.index ["work_location_id"], name: "index_bx_block_navmenu_internships_on_work_location_id"
    t.index ["work_schedule_id"], name: "index_bx_block_navmenu_internships_on_work_schedule_id"
  end

  create_table "bx_block_projectreporting_projects", force: :cascade do |t|
    t.string "name"
    t.bigint "manager_id"
    t.bigint "account_id"
    t.bigint "co_manager_id"
    t.integer "online_tool_ids", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_type", default: 0
    t.integer "client_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "assessor_ids", default: [], array: true
    t.decimal "max_score", precision: 10, scale: 2, default: "0.0"
    t.integer "assessor_tool_ids", default: [], array: true
    t.boolean "is_negative_marking", default: false
    t.decimal "negative_mark", precision: 10, scale: 2
    t.integer "question_ids", default: [], array: true
    t.integer "duration"
    t.integer "competancy_ids", default: [], array: true
  end

  create_table "bx_block_recommendation_catalogue_recommends", force: :cascade do |t|
    t.string "recommendation_setting"
    t.boolean "value"
  end

  create_table "bx_block_recommendation_recommendations", force: :cascade do |t|
    t.bigint "internship_id", null: false
    t.bigint "intern_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "score"
    t.bigint "role_id"
    t.integer "match_type"
    t.index ["intern_user_id"], name: "index_bx_block_recommendation_recommendations_on_intern_user_id"
    t.index ["internship_id"], name: "index_bx_block_recommendation_recommendations_on_internship_id"
  end

  create_table "bx_block_stripe_integration_customers", force: :cascade do |t|
    t.string "stripe_id"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_bx_block_stripe_integration_customers_on_account_id"
  end

  create_table "bx_block_stripe_integration_webhook_events", force: :cascade do |t|
    t.string "event_id"
    t.string "event_type"
    t.string "object_id"
    t.string "payable_reference"
    t.text "payload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_bx_block_stripe_integration_webhook_events_on_event_id"
    t.index ["event_type"], name: "index_bx_block_stripe_integration_webhook_events_on_event_type"
    t.index ["object_id"], name: "index_bx_block_stripe_integration_webhook_events_on_object_id"
    t.index ["payable_reference"], name: "index_bx_stripe_events_on_payable_ref"
  end

  create_table "bx_block_surveys_options", force: :cascade do |t|
    t.string "name"
    t.bigint "question_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_bx_block_surveys_options_on_question_id"
  end

  create_table "bx_block_surveys_questions", force: :cascade do |t|
    t.string "question_title"
    t.bigint "survey_id"
    t.integer "sequence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "question_type"
    t.integer "rating"
    t.integer "intern_characteristic_id"
    t.text "business_question"
    t.text "intern_question"
    t.integer "version_id"
    t.integer "default_weight"
    t.index ["survey_id"], name: "index_bx_block_surveys_questions_on_survey_id"
  end

  create_table "bx_block_surveys_submissions", force: :cascade do |t|
    t.text "answer"
    t.bigint "account_id"
    t.bigint "question_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "answer_type"
    t.integer "rating"
    t.string "option_ids", array: true
    t.bigint "version_id"
    t.bigint "option_id"
    t.float "option_value"
    t.bigint "intern_characteristic_id"
    t.bigint "default_weight"
    t.index ["account_id"], name: "index_bx_block_surveys_submissions_on_account_id"
    t.index ["question_id"], name: "index_bx_block_surveys_submissions_on_question_id"
  end

  create_table "bx_block_surveys_surveys", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "is_activated", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role_id"
  end

  create_table "bx_block_terms_and_conditions_terms_and_conditions", force: :cascade do |t|
    t.integer "account_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
  end

  create_table "bx_block_terms_and_conditions_user_term_and_conditions", force: :cascade do |t|
    t.integer "account_id"
    t.integer "terms_and_condition_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_accepted"
  end

  create_table "bx_block_wishlist_wishlists", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_bx_block_wishlist_wishlists_on_account_id"
    t.index ["item_id"], name: "index_bx_block_wishlist_wishlists_on_item_id"
  end

  create_table "career_interests", force: :cascade do |t|
    t.bigint "intern_user_id"
    t.bigint "industry_id"
    t.bigint "role_id"
    t.integer "update_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "careers", force: :cascade do |t|
    t.string "profession"
    t.boolean "is_current", default: false
    t.string "experience_from"
    t.string "experience_to"
    t.string "payscale"
    t.string "company_name"
    t.string "accomplishment", array: true
    t.integer "sector"
    t.integer "profile_bio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "catalogue_reviews", force: :cascade do |t|
    t.bigint "catalogue_id", null: false
    t.string "comment"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["catalogue_id"], name: "index_catalogue_reviews_on_catalogue_id"
  end

  create_table "catalogue_tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "catalogue_variant_colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "catalogue_variant_sizes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "catalogue_variants", force: :cascade do |t|
    t.bigint "catalogue_id", null: false
    t.bigint "catalogue_variant_color_id"
    t.bigint "catalogue_variant_size_id"
    t.decimal "price"
    t.integer "stock_qty"
    t.boolean "on_sale"
    t.decimal "sale_price"
    t.decimal "discount_price"
    t.float "length"
    t.float "breadth"
    t.float "height"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "block_qty"
    t.index ["catalogue_id"], name: "index_catalogue_variants_on_catalogue_id"
    t.index ["catalogue_variant_color_id"], name: "index_catalogue_variants_on_catalogue_variant_color_id"
    t.index ["catalogue_variant_size_id"], name: "index_catalogue_variants_on_catalogue_variant_size_id"
  end

  create_table "catalogues", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "sub_category_id", null: false
    t.bigint "brand_id"
    t.string "name"
    t.string "sku"
    t.string "description"
    t.datetime "manufacture_date"
    t.float "length"
    t.float "breadth"
    t.float "height"
    t.integer "availability"
    t.integer "stock_qty"
    t.decimal "weight"
    t.float "price"
    t.boolean "recommended"
    t.boolean "on_sale"
    t.decimal "sale_price"
    t.decimal "discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "block_qty"
    t.index ["brand_id"], name: "index_catalogues_on_brand_id"
    t.index ["category_id"], name: "index_catalogues_on_category_id"
    t.index ["sub_category_id"], name: "index_catalogues_on_sub_category_id"
  end

  create_table "catalogues_tags", force: :cascade do |t|
    t.bigint "catalogue_id", null: false
    t.bigint "catalogue_tag_id", null: false
    t.index ["catalogue_id"], name: "index_catalogues_tags_on_catalogue_id"
    t.index ["catalogue_tag_id"], name: "index_catalogues_tags_on_catalogue_tag_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "admin_user_id"
    t.integer "rank"
    t.string "light_icon"
    t.string "light_icon_active"
    t.string "light_icon_inactive"
    t.string "dark_icon"
    t.string "dark_icon_active"
    t.string "dark_icon_inactive"
    t.integer "identifier"
  end

  create_table "categories_sub_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "sub_category_id", null: false
    t.index ["category_id"], name: "index_categories_sub_categories_on_category_id"
    t.index ["sub_category_id"], name: "index_categories_sub_categories_on_sub_category_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "chat_id"
    t.string "message", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_mark_read", default: false
    t.integer "message_type"
    t.integer "read_by", default: [], array: true
    t.index ["account_id"], name: "index_chat_messages_on_account_id"
    t.index ["chat_id"], name: "index_chat_messages_on_chat_id"
  end

  create_table "chatbot_interviews", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "prompt_version_id", null: false
    t.bigint "request_interview_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.string "status", null: false
    t.string "termination_reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "intern_user_id"
    t.index ["account_id"], name: "index_chatbot_interviews_on_account_id"
    t.index ["prompt_version_id"], name: "index_chatbot_interviews_on_prompt_version_id"
  end

  create_table "chatbot_responses", force: :cascade do |t|
    t.bigint "chatbot_interview_id", null: false
    t.integer "prompt_index"
    t.text "question"
    t.text "answer"
    t.text "asked_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chatbot_interview_id"], name: "index_chatbot_responses_on_chatbot_interview_id"
  end

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: "", null: false
    t.integer "chat_type", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "country_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cod_values", force: :cascade do |t|
    t.bigint "shipment_id", null: false
    t.float "amount"
    t.string "currency", default: "RS"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipment_id"], name: "index_cod_values_on_shipment_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "commentable_id"
    t.string "commentable_type"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "actived", default: true
    t.index ["account_id"], name: "index_comments_on_account_id"
  end

  create_table "company_details", force: :cascade do |t|
    t.string "company_name"
    t.string "website_link"
    t.string "contact_number"
    t.text "address"
    t.text "company_description"
    t.bigint "country_id"
    t.bigint "industry_id"
    t.bigint "city_id"
    t.bigint "business_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "update_by"
    t.integer "country_code"
    t.bigint "phone_number"
    t.string "country_flag"
    t.index ["business_user_id"], name: "index_company_details_on_business_user_id"
    t.index ["city_id"], name: "index_company_details_on_city_id"
    t.index ["country_id"], name: "index_company_details_on_country_id"
    t.index ["industry_id"], name: "index_company_details_on_industry_id"
  end

  create_table "contact_interns", force: :cascade do |t|
    t.integer "decision", default: 0
    t.bigint "internship_id", null: false
    t.bigint "intern_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contact_us", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", null: false
    t.bigint "issue_type_id", null: false
    t.text "inquiry_details", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["issue_type_id"], name: "index_contact_us_on_issue_type_id"
  end

  create_table "coordinates", force: :cascade do |t|
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "addressable_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coupon_codes", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "code"
    t.string "discount_type", default: "flat"
    t.decimal "discount"
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.decimal "min_cart_value"
    t.decimal "max_cart_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "create_shipments", force: :cascade do |t|
    t.boolean "auto_assign_drivers", default: false
    t.string "requested_by"
    t.string "shipper_id"
    t.string "waybill"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cta", force: :cascade do |t|
    t.string "headline"
    t.text "description"
    t.bigint "category_id"
    t.string "long_background_image"
    t.string "square_background_image"
    t.string "button_text"
    t.string "redirect_url"
    t.integer "text_alignment"
    t.integer "button_alignment"
    t.boolean "is_square_cta"
    t.boolean "is_long_rectangle_cta"
    t.boolean "is_text_cta"
    t.boolean "is_image_cta"
    t.boolean "has_button"
    t.boolean "visible_on_home_page"
    t.boolean "visible_on_details_page"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_cta_on_category_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.bigint "shipment_id", null: false
    t.text "address"
    t.text "address2"
    t.string "city"
    t.string "country"
    t.string "email"
    t.string "name"
    t.string "phone"
    t.text "instructions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipment_id"], name: "index_deliveries_on_shipment_id"
  end

  create_table "delivery_address_orders", force: :cascade do |t|
    t.bigint "order_management_order_id", null: false
    t.bigint "delivery_address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["delivery_address_id"], name: "index_delivery_address_orders_on_delivery_address_id"
    t.index ["order_management_order_id"], name: "index_delivery_address_orders_on_order_management_order_id"
  end

  create_table "delivery_addresses", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "address"
    t.string "name"
    t.string "flat_no"
    t.string "zip_code"
    t.string "phone_number"
    t.datetime "deleted_at"
    t.float "latitude"
    t.float "longitude"
    t.boolean "residential", default: true
    t.string "city"
    t.string "state_code"
    t.string "country_code"
    t.string "state"
    t.string "country"
    t.string "address_line_2"
    t.string "address_type", default: "home"
    t.string "address_for", default: "shipping"
    t.boolean "is_default", default: false
    t.string "landmark"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_delivery_addresses_on_account_id"
  end

  create_table "dimensions", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.float "height"
    t.float "length"
    t.float "width"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_dimensions_on_item_id"
  end

  create_table "educational_statuses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "educations", force: :cascade do |t|
    t.string "qualification"
    t.integer "profile_bio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "year_from"
    t.string "year_to"
    t.text "description"
  end

  create_table "email_notifications", force: :cascade do |t|
    t.bigint "notification_id", null: false
    t.string "send_to_email"
    t.datetime "sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_id"], name: "index_email_notifications_on_notification_id"
  end

  create_table "email_otps", force: :cascade do |t|
    t.string "email"
    t.integer "pin"
    t.boolean "activated", default: false, null: false
    t.datetime "valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favourites", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "favouriteable_id"
    t.string "favouriteable_type"
    t.integer "user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "account_id"
    t.integer "follow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "follow_id"], name: "index_follows_on_account_id_and_follow_id", unique: true
    t.index ["account_id"], name: "index_follows_on_account_id"
    t.index ["follow_id"], name: "index_follows_on_follow_id"
  end

  create_table "global_settings", force: :cascade do |t|
    t.string "notice_period"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "intern_characteristic_importances", force: :cascade do |t|
    t.bigint "user_surveys_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "intern_characteristic_id"
    t.bigint "value"
    t.index ["user_surveys_id"], name: "index_intern_characteristic_importances_on_user_surveys_id"
  end

  create_table "intern_characteristics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "intern_user_generic_answers", force: :cascade do |t|
    t.bigint "internship_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "answer"
    t.bigint "intern_user_generic_question_id", null: false
    t.index ["account_id"], name: "index_intern_user_generic_answers_on_account_id"
    t.index ["intern_user_generic_question_id"], name: "intern_user_generic_answers_on_question_id"
    t.index ["internship_id"], name: "index_intern_user_generic_answers_on_internship_id"
  end

  create_table "intern_user_generic_questions", force: :cascade do |t|
    t.bigint "business_user_id", null: false
    t.bigint "internship_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "question"
    t.index ["business_user_id"], name: "index_intern_user_generic_questions_on_business_user_id"
    t.index ["internship_id"], name: "index_intern_user_generic_questions_on_internship_id"
  end

  create_table "issue_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.bigint "shipment_id", null: false
    t.string "ref_id"
    t.float "weight"
    t.integer "quantity"
    t.boolean "stackable", default: true
    t.integer "item_type", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipment_id"], name: "index_items_on_shipment_id"
  end

  create_table "like_posts", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_like_posts_on_account_id"
    t.index ["post_id"], name: "index_like_posts_on_post_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "like_by_id"
    t.string "likeable_type", null: false
    t.bigint "likeable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "account_id"
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.integer "van_id"
    t.text "address"
    t.string "locationable_type"
    t.bigint "locationable_id"
    t.index ["locationable_type", "locationable_id"], name: "index_locations_on_locationable_type_and_locationable_id"
  end

  create_table "make_offers", force: :cascade do |t|
    t.bigint "intern_user_id", null: false
    t.bigint "business_user_id", null: false
    t.bigint "internship_id", null: false
    t.integer "offer_status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number_of_days"
    t.index ["business_user_id"], name: "index_make_offers_on_business_user_id"
    t.index ["intern_user_id", "internship_id"], name: "index_make_offers_on_intern_user_id_and_internship_id", unique: true
    t.index ["intern_user_id"], name: "index_make_offers_on_intern_user_id"
    t.index ["internship_id"], name: "index_make_offers_on_internship_id"
  end

  create_table "navigation_menus", force: :cascade do |t|
    t.string "position", comment: "Where will this navigation item be present"
    t.json "items", comment: "Navigation Menu Items, combination of url and name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notification_groups", force: :cascade do |t|
    t.integer "group_type"
    t.string "group_name"
    t.bigint "notification_setting_id", null: false
    t.integer "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_setting_id"], name: "index_notification_groups_on_notification_setting_id"
  end

  create_table "notification_settings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.boolean "turn_off_deadline_reminders", default: true
    t.boolean "turn_off_perfect_match_notifications", default: true
    t.boolean "turn_off_recommendation_notifications", default: true
    t.boolean "turn_off_shortlist_notifications", default: true
    t.boolean "turn_off_application_status_updates", default: true
    t.boolean "turn_off_updates_on_saved_internships", default: true
    t.boolean "turn_off_feedback_notifications", default: true
    t.boolean "turn_off_interview_invitations", default: true
    t.boolean "turn_off_internview_reminders", default: true
    t.boolean "turn_off_new_application_alerts", default: true
    t.boolean "turn_off_incomplete_application_notifications", default: true
    t.boolean "turn_off_interview_notifications", default: true
    t.boolean "turn_off_expiration_alerts", default: true
    t.boolean "turn_off_interview_reminders", default: true
    t.boolean "turn_off_feedback_requests", default: true
  end

  create_table "notification_subgroups", force: :cascade do |t|
    t.integer "subgroup_type"
    t.string "subgroup_name"
    t.bigint "notification_group_id", null: false
    t.integer "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_group_id"], name: "index_notification_subgroups_on_notification_group_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "created_by"
    t.string "headings"
    t.string "contents"
    t.string "app_url"
    t.boolean "is_read", default: false
    t.datetime "read_at"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "navigates_to"
    t.string "match_type"
    t.index ["account_id"], name: "index_notifications_on_account_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_management_order_id", null: false
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "total_price"
    t.decimal "old_unit_price"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "catalogue_id", null: false
    t.bigint "catalogue_variant_id", null: false
    t.integer "order_status_id"
    t.datetime "placed_at"
    t.datetime "confirmed_at"
    t.datetime "in_transit_at"
    t.datetime "delivered_at"
    t.datetime "cancelled_at"
    t.datetime "refunded_at"
    t.boolean "manage_placed_status", default: false
    t.boolean "manage_cancelled_status", default: false
    t.index ["catalogue_id"], name: "index_order_items_on_catalogue_id"
    t.index ["catalogue_variant_id"], name: "index_order_items_on_catalogue_variant_id"
    t.index ["order_management_order_id"], name: "index_order_items_on_order_management_order_id"
  end

  create_table "order_management_orders", force: :cascade do |t|
    t.string "order_number"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.bigint "coupon_code_id"
    t.bigint "delivery_address_id"
    t.decimal "sub_total", default: "0.0"
    t.decimal "total", default: "0.0"
    t.string "status"
    t.decimal "applied_discount", default: "0.0"
    t.text "cancellation_reason"
    t.datetime "order_date"
    t.boolean "is_gift", default: false
    t.datetime "placed_at"
    t.datetime "confirmed_at"
    t.datetime "in_transit_at"
    t.datetime "delivered_at"
    t.datetime "cancelled_at"
    t.datetime "refunded_at"
    t.string "source"
    t.string "shipment_id"
    t.string "delivery_charges"
    t.string "tracking_url"
    t.datetime "schedule_time"
    t.datetime "payment_failed_at"
    t.datetime "returned_at"
    t.decimal "tax_charges", default: "0.0"
    t.integer "deliver_by"
    t.string "tracking_number"
    t.boolean "is_error", default: false
    t.string "delivery_error_message"
    t.datetime "payment_pending_at"
    t.integer "order_status_id"
    t.boolean "is_group", default: true
    t.boolean "is_availability_checked", default: false
    t.decimal "shipping_charge"
    t.decimal "shipping_discount"
    t.decimal "shipping_net_amt"
    t.decimal "shipping_total"
    t.float "total_tax"
    t.string "razorpay_order_id"
    t.boolean "charged"
    t.boolean "invoiced"
    t.string "invoice_id"
    t.string "custom_label"
    t.index ["account_id"], name: "index_order_management_orders_on_account_id"
    t.index ["coupon_code_id"], name: "index_order_management_orders_on_coupon_code_id"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.boolean "active", default: true
    t.string "event_name"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_trackings", force: :cascade do |t|
    t.string "parent_type"
    t.bigint "parent_id"
    t.integer "tracking_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_type", "parent_id"], name: "index_order_trackings_on_parent_type_and_parent_id"
  end

  create_table "order_transactions", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "order_management_order_id", null: false
    t.string "charge_id"
    t.integer "amount"
    t.string "currency"
    t.string "charge_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_order_transactions_on_account_id"
    t.index ["order_management_order_id"], name: "index_order_transactions_on_order_management_order_id"
  end

  create_table "payment_admins", force: :cascade do |t|
    t.string "transaction_id"
    t.bigint "account_id", null: false
    t.bigint "current_user_id"
    t.string "payment_status"
    t.integer "payment_method"
    t.decimal "user_amount", precision: 10, scale: 2
    t.decimal "post_creator_amount", precision: 10, scale: 2
    t.decimal "third_party_amount", precision: 10, scale: 2
    t.decimal "admin_amount", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_payment_admins_on_account_id"
    t.index ["current_user_id"], name: "index_payment_admins_on_current_user_id"
  end

  create_table "pickups", force: :cascade do |t|
    t.bigint "shipment_id", null: false
    t.text "address"
    t.text "address2"
    t.string "city"
    t.string "country"
    t.string "email"
    t.string "name"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipment_id"], name: "index_pickups_on_shipment_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "body"
    t.string "location"
    t.integer "account_id"
    t.bigint "sub_category_id"
    t.index ["category_id"], name: "index_posts_on_category_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.integer "seeking"
    t.string "discover_people", array: true
    t.text "location"
    t.integer "distance"
    t.integer "height_type"
    t.integer "body_type"
    t.integer "religion"
    t.integer "smoking"
    t.integer "drinking"
    t.integer "profile_bio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "friend", default: false
    t.boolean "business", default: false
    t.boolean "match_making", default: false
    t.boolean "travel_partner", default: false
    t.boolean "cross_path", default: false
    t.integer "age_range_start"
    t.integer "age_range_end"
    t.string "height_range_start"
    t.string "height_range_end"
    t.integer "account_id"
  end

  create_table "print_prices", force: :cascade do |t|
    t.string "page_size"
    t.string "colors"
    t.float "single_side"
    t.float "double_side"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "privacy_policies", force: :cascade do |t|
    t.integer "account_type"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profile_bios", force: :cascade do |t|
    t.integer "account_id"
    t.string "height"
    t.string "weight"
    t.integer "height_type"
    t.integer "weight_type"
    t.integer "body_type"
    t.integer "mother_tougue"
    t.integer "religion"
    t.integer "zodiac"
    t.integer "marital_status"
    t.string "languages", array: true
    t.text "about_me"
    t.string "personality", array: true
    t.string "interests", array: true
    t.integer "smoking"
    t.integer "drinking"
    t.integer "looking_for"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "about_business"
    t.jsonb "custom_attributes"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "address"
    t.string "postal_code"
    t.integer "account_id"
    t.string "photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "country_id"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_profiles_on_city_id"
    t.index ["country_id"], name: "index_profiles_on_country_id"
  end

  create_table "prompt_managers", force: :cascade do |t|
    t.text "criteria"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prompt_versions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "prompt_manager_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prompt_manager_id"], name: "index_prompt_versions_on_prompt_manager_id"
  end

  create_table "push_notifications", force: :cascade do |t|
    t.bigint "account_id"
    t.string "push_notificable_type", null: false
    t.bigint "push_notificable_id", null: false
    t.string "remarks"
    t.boolean "is_read", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "notify_type"
    t.index ["account_id"], name: "index_push_notifications_on_account_id"
    t.index ["push_notificable_type", "push_notificable_id"], name: "index_push_notification_type_and_id"
  end

  create_table "question_answers", force: :cascade do |t|
    t.string "question"
    t.text "answer"
    t.bigint "question_sub_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_sub_type_id"], name: "index_question_answers_on_question_sub_type_id"
  end

  create_table "question_sub_types", force: :cascade do |t|
    t.string "sub_type"
    t.text "description"
    t.bigint "question_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_type_id"], name: "index_question_sub_types_on_question_type_id"
  end

  create_table "question_types", force: :cascade do |t|
    t.string "que_type"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recurring_subscriptions", force: :cascade do |t|
    t.string "name"
    t.string "fee"
    t.date "billing_date"
    t.integer "billing_frequency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_recurring_subscriptions_on_account_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "created_by_id"
    t.bigint "created_for_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "internship_id"
    t.index ["created_by_id"], name: "index_reports_on_created_by_id"
    t.index ["created_for_id"], name: "index_reports_on_created_for_id"
  end

  create_table "request_interviews", force: :cascade do |t|
    t.bigint "intern_user_id", null: false
    t.bigint "business_user_id", null: false
    t.bigint "internship_id", null: false
    t.integer "status", default: 0, null: false
    t.integer "number_of_days", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_user_id"], name: "index_request_interviews_on_business_user_id"
    t.index ["intern_user_id", "internship_id"], name: "index_request_interviews_on_intern_user_id_and_internship_id", unique: true
    t.index ["intern_user_id"], name: "index_request_interviews_on_intern_user_id"
    t.index ["internship_id"], name: "index_request_interviews_on_internship_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "status", default: 0
    t.integer "account_group_id"
    t.string "request_text"
    t.string "rejection_reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
  end

  create_table "reviews_reviews", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "account_id"
    t.integer "reviewer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "anonymous", default: false
    t.integer "internship_id"
    t.integer "rating"
    t.integer "prompt_manager_id"
    t.integer "version_id"
    t.string "reviews_type"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "industry_id"
  end

  create_table "school_educations", force: :cascade do |t|
    t.bigint "intern_user_id"
    t.bigint "educational_status_id"
    t.bigint "school_id"
    t.string "school_name"
    t.bigint "academic_level_id"
    t.string "academic_achievement"
    t.string "extracurricular_activity"
    t.string "soft_skill"
    t.string "interest"
    t.string "hobby"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_id"], name: "index_school_educations_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.bigint "educational_status_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["educational_status_id"], name: "index_schools_on_educational_status_id"
  end

  create_table "seller_accounts", force: :cascade do |t|
    t.string "firm_name"
    t.string "full_phone_number"
    t.text "location"
    t.integer "country_code"
    t.bigint "phone_number"
    t.string "gstin_number"
    t.boolean "wholesaler"
    t.boolean "retailer"
    t.boolean "manufacturer"
    t.boolean "hallmarking_center"
    t.float "buy_gold"
    t.float "buy_silver"
    t.float "sell_gold"
    t.float "sell_silver"
    t.string "deal_in", default: [], array: true
    t.text "about_us"
    t.boolean "activated", default: false, null: false
    t.bigint "account_id", null: false
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "long", precision: 10, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_seller_accounts_on_account_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "title"
    t.string "name"
  end

  create_table "share_records", force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "account_id"
    t.integer "shared_to_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_share_records_on_account_id"
    t.index ["post_id"], name: "index_share_records_on_post_id"
  end

  create_table "shipment_values", force: :cascade do |t|
    t.bigint "shipment_id", null: false
    t.float "amount"
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipment_id"], name: "index_shipment_values_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.bigint "create_shipment_id", null: false
    t.string "ref_id"
    t.boolean "full_truck", default: false
    t.text "load_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["create_shipment_id"], name: "index_shipments_on_create_shipment_id"
  end

  create_table "sms_otps", force: :cascade do |t|
    t.string "full_phone_number"
    t.integer "pin"
    t.boolean "activated", default: false, null: false
    t.datetime "valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_id"
    t.integer "rank"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.string "tenant", limit: 128
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
    t.index ["tenant"], name: "index_taggings_on_tenant"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "thresholds", force: :cascade do |t|
    t.integer "threshold_percentage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trackings", force: :cascade do |t|
    t.string "status"
    t.string "tracking_number"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "universities", force: :cascade do |t|
    t.bigint "educational_status_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["educational_status_id"], name: "index_universities_on_educational_status_id"
  end

  create_table "university_educations", force: :cascade do |t|
    t.bigint "intern_user_id"
    t.bigint "educational_status_id"
    t.bigint "university_id"
    t.string "university_name"
    t.string "specialisation"
    t.integer "graduation_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["university_id"], name: "index_university_educations_on_university_id"
  end

  create_table "user_categories", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_user_categories_on_account_id"
    t.index ["category_id"], name: "index_user_categories_on_category_id"
  end

  create_table "user_sub_categories", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "sub_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_user_sub_categories_on_account_id"
    t.index ["sub_category_id"], name: "index_user_sub_categories_on_sub_category_id"
  end

  create_table "user_surveys", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "career_interest_id"
    t.bigint "internship_id"
    t.bigint "role_id"
    t.bigint "version_id"
    t.string "quiz_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "retake", default: false
    t.index ["account_id"], name: "index_user_surveys_on_account_id"
    t.index ["career_interest_id"], name: "index_user_surveys_on_career_interest_id"
  end

  create_table "van_members", force: :cascade do |t|
    t.integer "account_id"
    t.integer "van_id"
  end

  create_table "vans", force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.boolean "is_offline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "versions", force: :cascade do |t|
    t.integer "survey_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "view_profiles", force: :cascade do |t|
    t.integer "profile_bio_id"
    t.integer "view_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "account_id"
  end

  create_table "work_locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
  end

  create_table "work_schedules", force: :cascade do |t|
    t.string "schedule"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
  end

  add_foreign_key "account_groups_account_groups", "account_groups_groups"
  add_foreign_key "account_groups_account_groups", "accounts"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addressables", "shipments"
  add_foreign_key "admin_notifications", "active_storage_attachments", column: "attachment_id"
  add_foreign_key "attachments", "accounts"
  add_foreign_key "black_list_users", "accounts"
  add_foreign_key "block_users", "accounts"
  add_foreign_key "block_users", "accounts", column: "current_user_id"
  add_foreign_key "business_user_generic_answers", "accounts", column: "business_user_id"
  add_foreign_key "business_user_generic_answers", "business_user_generic_questions"
  add_foreign_key "business_user_generic_answers", "bx_block_navmenu_internships", column: "internship_id"
  add_foreign_key "bx_block_addfriends_connections", "accounts"
  add_foreign_key "bx_block_attachment_file_attachments", "accounts"
  add_foreign_key "bx_block_navmenu_internships", "accounts", column: "business_user_id"
  add_foreign_key "bx_block_navmenu_internships", "cities"
  add_foreign_key "bx_block_navmenu_internships", "countries"
  add_foreign_key "bx_block_navmenu_internships", "industries"
  add_foreign_key "bx_block_navmenu_internships", "roles"
  add_foreign_key "bx_block_navmenu_internships", "work_locations"
  add_foreign_key "bx_block_navmenu_internships", "work_schedules"
  add_foreign_key "bx_block_stripe_integration_customers", "accounts"
  add_foreign_key "bx_block_wishlist_wishlists", "accounts"
  add_foreign_key "bx_block_wishlist_wishlists", "items"
  add_foreign_key "catalogue_reviews", "catalogues"
  add_foreign_key "catalogue_variants", "catalogue_variant_colors"
  add_foreign_key "catalogue_variants", "catalogue_variant_sizes"
  add_foreign_key "catalogue_variants", "catalogues"
  add_foreign_key "catalogues", "brands"
  add_foreign_key "catalogues", "categories"
  add_foreign_key "catalogues", "sub_categories"
  add_foreign_key "catalogues_tags", "catalogue_tags"
  add_foreign_key "catalogues_tags", "catalogues"
  add_foreign_key "categories_sub_categories", "categories"
  add_foreign_key "categories_sub_categories", "sub_categories"
  add_foreign_key "chat_messages", "accounts"
  add_foreign_key "chat_messages", "chats"
  add_foreign_key "chatbot_interviews", "accounts"
  add_foreign_key "chatbot_interviews", "prompt_versions"
  add_foreign_key "chatbot_responses", "chatbot_interviews"
  add_foreign_key "cod_values", "shipments"
  add_foreign_key "comments", "accounts"
  add_foreign_key "company_details", "accounts", column: "business_user_id"
  add_foreign_key "company_details", "cities"
  add_foreign_key "company_details", "countries"
  add_foreign_key "company_details", "industries"
  add_foreign_key "contact_us", "issue_types"
  add_foreign_key "deliveries", "shipments"
  add_foreign_key "delivery_address_orders", "delivery_addresses"
  add_foreign_key "delivery_address_orders", "order_management_orders"
  add_foreign_key "delivery_addresses", "accounts"
  add_foreign_key "dimensions", "items"
  add_foreign_key "email_notifications", "notifications"
  add_foreign_key "intern_characteristic_importances", "user_surveys", column: "user_surveys_id"
  add_foreign_key "intern_user_generic_answers", "accounts"
  add_foreign_key "intern_user_generic_answers", "bx_block_navmenu_internships", column: "internship_id"
  add_foreign_key "intern_user_generic_answers", "intern_user_generic_questions"
  add_foreign_key "intern_user_generic_questions", "accounts", column: "business_user_id"
  add_foreign_key "intern_user_generic_questions", "bx_block_navmenu_internships", column: "internship_id"
  add_foreign_key "items", "shipments"
  add_foreign_key "like_posts", "accounts"
  add_foreign_key "like_posts", "posts"
  add_foreign_key "make_offers", "accounts", column: "business_user_id"
  add_foreign_key "make_offers", "accounts", column: "intern_user_id"
  add_foreign_key "make_offers", "bx_block_navmenu_internships", column: "internship_id"
  add_foreign_key "notification_groups", "notification_settings"
  add_foreign_key "notification_subgroups", "notification_groups"
  add_foreign_key "notifications", "accounts"
  add_foreign_key "order_items", "catalogue_variants"
  add_foreign_key "order_items", "catalogues"
  add_foreign_key "order_items", "order_management_orders"
  add_foreign_key "order_transactions", "accounts"
  add_foreign_key "order_transactions", "order_management_orders"
  add_foreign_key "payment_admins", "accounts"
  add_foreign_key "payment_admins", "accounts", column: "current_user_id"
  add_foreign_key "pickups", "shipments"
  add_foreign_key "push_notifications", "accounts"
  add_foreign_key "question_answers", "question_sub_types"
  add_foreign_key "question_sub_types", "question_types"
  add_foreign_key "recurring_subscriptions", "accounts"
  add_foreign_key "reports", "accounts", column: "created_by_id"
  add_foreign_key "reports", "accounts", column: "created_for_id"
  add_foreign_key "request_interviews", "accounts", column: "business_user_id"
  add_foreign_key "request_interviews", "accounts", column: "intern_user_id"
  add_foreign_key "request_interviews", "bx_block_navmenu_internships", column: "internship_id"
  add_foreign_key "schools", "educational_statuses"
  add_foreign_key "seller_accounts", "accounts"
  add_foreign_key "share_records", "accounts"
  add_foreign_key "share_records", "posts"
  add_foreign_key "shipment_values", "shipments"
  add_foreign_key "shipments", "create_shipments"
  add_foreign_key "taggings", "tags"
  add_foreign_key "universities", "educational_statuses"
  add_foreign_key "user_categories", "accounts"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_sub_categories", "accounts"
  add_foreign_key "user_sub_categories", "sub_categories"
  add_foreign_key "user_surveys", "accounts"
  add_foreign_key "user_surveys", "career_interests"
end
