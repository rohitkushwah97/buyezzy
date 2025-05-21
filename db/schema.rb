# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2025_05_06_111224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_categories", force: :cascade do |t|
    t.integer "account_id"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "account_promo_codes", force: :cascade do |t|
    t.integer "redeem_count", default: 0, null: false
    t.bigint "promo_code_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_account_promo_codes_on_account_id"
    t.index ["promo_code_id"], name: "index_account_promo_codes_on_promo_code_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "full_phone_number"
    t.integer "country_code"
    t.bigint "phone_number"
    t.string "email"
    t.boolean "activated", default: false, null: false
    t.string "device_id"
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
    t.string "stripe_id"
    t.string "stripe_subscription_id"
    t.datetime "stripe_subscription_date"
    t.string "full_name"
    t.integer "role_id"
    t.integer "gender"
    t.date "date_of_birth"
    t.integer "age"
    t.boolean "is_paid", default: false
    t.string "company_or_store_name"
    t.string "language"
    t.integer "current_order"
    t.string "reset_token"
    t.datetime "reset_token_used_at"
    t.index ["activated"], name: "index_accounts_on_activated"
    t.index ["company_or_store_name"], name: "index_accounts_on_company_or_store_name"
    t.index ["current_order"], name: "index_accounts_on_current_order"
    t.index ["email"], name: "index_accounts_on_email"
    t.index ["first_name"], name: "index_accounts_on_first_name"
    t.index ["full_name"], name: "index_accounts_on_full_name"
    t.index ["full_phone_number"], name: "index_accounts_on_full_phone_number"
    t.index ["is_blacklisted"], name: "index_accounts_on_is_blacklisted"
    t.index ["language"], name: "index_accounts_on_language"
    t.index ["last_name"], name: "index_accounts_on_last_name"
    t.index ["last_visit_at"], name: "index_accounts_on_last_visit_at"
    t.index ["phone_number"], name: "index_accounts_on_phone_number"
    t.index ["user_type"], name: "index_accounts_on_user_type"
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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
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

  create_table "activity_logs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "user_email"
    t.string "user_type"
    t.datetime "accessed_at"
    t.string "action"
    t.text "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accessed_at"], name: "index_activity_logs_on_accessed_at"
    t.index ["action"], name: "index_activity_logs_on_action"
    t.index ["user_email"], name: "index_activity_logs_on_user_email"
    t.index ["user_id"], name: "index_activity_logs_on_user_id"
    t.index ["user_type"], name: "index_activity_logs_on_user_type"
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
    t.string "city"
    t.string "state"
    t.string "email"
    t.string "contact_number"
    t.integer "seller_id"
  end

  create_table "admin_replies", force: :cascade do |t|
    t.integer "contact_id"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_admin_replies_on_contact_id"
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

  create_table "advertisements", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "duration"
    t.integer "advertisement_for"
    t.integer "status"
    t.integer "seller_account_id"
    t.datetime "start_at"
    t.datetime "expire_at"
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
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

  create_table "associated_projects", force: :cascade do |t|
    t.integer "project_id"
    t.integer "associated_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "associateds", force: :cascade do |t|
    t.string "associated_with_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "attribute_options", force: :cascade do |t|
    t.string "option"
    t.bigint "variant_attribute_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["option"], name: "index_attribute_options_on_option"
    t.index ["variant_attribute_id"], name: "index_attribute_options_on_variant_attribute_id"
  end

  create_table "author_favorite_books", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status", default: false
    t.index ["status"], name: "index_author_favorite_books_on_status"
    t.index ["title"], name: "index_author_favorite_books_on_title"
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

  create_table "awards", force: :cascade do |t|
    t.string "title"
    t.string "associated_with"
    t.string "issuer"
    t.datetime "issue_date"
    t.text "description"
    t.boolean "make_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "banner_groups", force: :cascade do |t|
    t.string "group_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_name"], name: "index_banner_groups_on_group_name"
  end

  create_table "banners", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "button_text"
    t.string "button_link"
    t.integer "banner_type"
    t.integer "section"
    t.bigint "banner_group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "catalogue_id"
    t.bigint "category_id"
    t.bigint "sub_category_id"
    t.bigint "deal_id"
    t.boolean "status", default: false
    t.index ["banner_group_id"], name: "index_banners_on_banner_group_id"
    t.index ["banner_type"], name: "index_banners_on_banner_type"
    t.index ["button_link"], name: "index_banners_on_button_link"
    t.index ["button_text"], name: "index_banners_on_button_text"
    t.index ["catalogue_id"], name: "index_banners_on_catalogue_id"
    t.index ["category_id"], name: "index_banners_on_category_id"
    t.index ["deal_id"], name: "index_banners_on_deal_id"
    t.index ["section"], name: "index_banners_on_section"
    t.index ["status"], name: "index_banners_on_status"
    t.index ["sub_category_id"], name: "index_banners_on_sub_category_id"
    t.index ["title"], name: "index_banners_on_title"
  end

  create_table "barcodes", force: :cascade do |t|
    t.string "bar_code"
    t.bigint "catalogue_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status", default: false
    t.index ["bar_code"], name: "index_barcodes_on_bar_code"
    t.index ["catalogue_id"], name: "index_barcodes_on_catalogue_id"
    t.index ["status"], name: "index_barcodes_on_status"
  end

  create_table "black_list_users", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_black_list_users_on_account_id"
  end

  create_table "brands", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "brand_name"
    t.string "brand_name_arabic"
    t.string "brand_website"
    t.integer "brand_year"
    t.boolean "approve"
    t.boolean "restricted", default: false
    t.boolean "gated", default: false
    t.integer "account_id"
    t.index ["account_id"], name: "index_brands_on_account_id"
    t.index ["approve"], name: "index_brands_on_approve"
    t.index ["brand_name"], name: "index_brands_on_brand_name"
    t.index ["brand_name_arabic"], name: "index_brands_on_brand_name_arabic"
    t.index ["brand_website"], name: "index_brands_on_brand_website"
    t.index ["brand_year"], name: "index_brands_on_brand_year"
    t.index ["restricted"], name: "index_brands_on_restricted"
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

  create_table "bx_block_termsandconditions_privacy_nad_legal_policies", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["status"], name: "index_privacy_legal_policies_on_status"
    t.index ["title"], name: "index_privacy_legal_policies_on_title"
  end

  create_table "career_experience_employment_types", force: :cascade do |t|
    t.integer "career_experience_id"
    t.integer "employment_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "career_experience_industry", force: :cascade do |t|
    t.integer "career_experience_id"
    t.integer "industry_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "career_experience_system_experiences", force: :cascade do |t|
    t.integer "career_experience_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "system_experience_id"
  end

  create_table "career_experiences", force: :cascade do |t|
    t.string "job_title"
    t.date "start_date"
    t.date "end_date"
    t.string "company_name"
    t.text "description"
    t.string "add_key_achievements", default: [], array: true
    t.boolean "make_key_achievements_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "current_salary", default: "0.0"
    t.text "notice_period"
    t.date "notice_period_end_date"
    t.boolean "currently_working_here", default: false
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

  create_table "catalogue_contents", force: :cascade do |t|
    t.string "custom_field_name"
    t.string "value"
    t.bigint "custom_field_id", null: false
    t.bigint "catalogue_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status", default: false
    t.index ["catalogue_id"], name: "index_catalogue_contents_on_catalogue_id"
    t.index ["custom_field_id"], name: "index_catalogue_contents_on_custom_field_id"
    t.index ["custom_field_name"], name: "index_catalogue_contents_on_custom_field_name"
    t.index ["value"], name: "index_catalogue_contents_on_value"
  end

  create_table "catalogue_offers", force: :cascade do |t|
    t.decimal "price_info"
    t.decimal "sale_price"
    t.bigint "barcode_id"
    t.string "bar_code_info"
    t.date "sale_schedule_from"
    t.date "sale_schedule_to"
    t.string "warranty"
    t.string "comments"
    t.boolean "status"
    t.bigint "catalogue_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bar_code_info"], name: "index_catalogue_offers_on_bar_code_info"
    t.index ["barcode_id"], name: "index_catalogue_offers_on_barcode_id"
    t.index ["catalogue_id"], name: "index_catalogue_offers_on_catalogue_id"
    t.index ["price_info"], name: "index_catalogue_offers_on_price_info"
    t.index ["sale_price"], name: "index_catalogue_offers_on_sale_price"
    t.index ["sale_schedule_from"], name: "index_catalogue_offers_on_sale_schedule_from"
    t.index ["sale_schedule_to"], name: "index_catalogue_offers_on_sale_schedule_to"
    t.index ["status"], name: "index_catalogue_offers_on_status"
    t.index ["warranty"], name: "index_catalogue_offers_on_warranty"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "group_name"
    t.bigint "seller_id", null: false
    t.bigint "micro_category_id"
    t.index ["group_name"], name: "index_catalogue_variants_on_group_name"
    t.index ["micro_category_id"], name: "index_catalogue_variants_on_micro_category_id"
    t.index ["seller_id"], name: "index_catalogue_variants_on_seller_id"
  end

  create_table "catalogues", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "brand_id"
    t.string "sku"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "besku"
    t.boolean "status", default: false
    t.bigint "warehouse_id"
    t.string "product_title"
    t.bigint "sub_category_id"
    t.bigint "mini_category_id"
    t.bigint "micro_category_id"
    t.bigint "seller_id"
    t.bigint "parent_catalogue_id"
    t.string "fulfilled_type"
    t.string "product_type", default: "standard"
    t.string "content_status"
    t.integer "stocks", default: 0
    t.integer "purchased_count", default: 0
    t.integer "recommended_priority", default: 0
    t.boolean "is_variant", default: false
    t.bigint "parent_product_id"
    t.string "bibc"
    t.decimal "final_price", precision: 15, scale: 2, default: "0.0"
    t.float "offer_percentage", default: 0.0
    t.float "stroked_price", default: 0.0
    t.index ["besku"], name: "index_catalogues_on_besku"
    t.index ["bibc"], name: "index_catalogues_on_bibc"
    t.index ["brand_id"], name: "index_catalogues_on_brand_id"
    t.index ["category_id"], name: "index_catalogues_on_category_id"
    t.index ["content_status"], name: "index_catalogues_on_content_status"
    t.index ["final_price"], name: "index_catalogues_on_final_price"
    t.index ["fulfilled_type"], name: "index_catalogues_on_fulfilled_type"
    t.index ["is_variant"], name: "index_catalogues_on_is_variant"
    t.index ["micro_category_id"], name: "index_catalogues_on_micro_category_id"
    t.index ["mini_category_id"], name: "index_catalogues_on_mini_category_id"
    t.index ["parent_catalogue_id"], name: "index_catalogues_on_parent_catalogue_id"
    t.index ["parent_product_id"], name: "index_catalogues_on_parent_product_id"
    t.index ["product_title"], name: "index_catalogues_on_product_title"
    t.index ["product_type"], name: "index_catalogues_on_product_type"
    t.index ["purchased_count"], name: "index_catalogues_on_purchased_count"
    t.index ["recommended_priority"], name: "index_catalogues_on_recommended_priority"
    t.index ["seller_id"], name: "index_catalogues_on_seller_id"
    t.index ["sku"], name: "index_catalogues_on_sku"
    t.index ["status"], name: "index_catalogues_on_status"
    t.index ["stocks"], name: "index_catalogues_on_stocks"
    t.index ["sub_category_id"], name: "index_catalogues_on_sub_category_id"
  end

  create_table "catalogues_store_menus", id: false, force: :cascade do |t|
    t.bigint "store_menu_id", null: false
    t.bigint "catalogue_id", null: false
    t.index ["catalogue_id", "store_menu_id"], name: "index_catalogues_store_menus_on_catalogue_id_and_store_menu_id"
    t.index ["store_menu_id", "catalogue_id"], name: "index_catalogues_store_menus_on_store_menu_id_and_catalogue_id"
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
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "chat_id"
    t.string "message", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_mark_read", default: false
    t.integer "message_type"
    t.string "attachment"
    t.index ["account_id"], name: "index_chat_messages_on_account_id"
    t.index ["chat_id"], name: "index_chat_messages_on_chat_id"
  end

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: "", null: false
    t.integer "chat_type", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
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
    t.index ["account_id"], name: "index_comments_on_account_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "email"
    t.string "phone_number"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "contact_type"
    t.string "last_name"
    t.string "title"
    t.index ["contact_type"], name: "index_contacts_on_contact_type"
    t.index ["email"], name: "index_contacts_on_email"
    t.index ["first_name"], name: "index_contacts_on_first_name"
    t.index ["last_name"], name: "index_contacts_on_last_name"
    t.index ["phone_number"], name: "index_contacts_on_phone_number"
    t.index ["title"], name: "index_contacts_on_title"
  end

  create_table "coordinates", force: :cascade do |t|
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "addressable_id"
  end

  create_table "coupon_codes", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "code"
    t.string "discount_type", default: "percentage"
    t.integer "discount", default: 0
    t.datetime "valid_from"
    t.datetime "valid_to"
    t.decimal "min_cart_value"
    t.decimal "max_cart_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_coupon_codes_on_account_id"
  end

  create_table "coupons_accounts", force: :cascade do |t|
    t.bigint "coupon_id"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_coupons_accounts_on_account_id"
    t.index ["coupon_id"], name: "index_coupons_accounts_on_coupon_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_name"
    t.string "duration"
    t.string "year"
    t.integer "profile_id"
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

  create_table "current_annual_salaries", force: :cascade do |t|
    t.string "current_annual_salary"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "current_annual_salary_current_status", force: :cascade do |t|
    t.integer "current_status_id"
    t.integer "current_annual_salary_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "current_status", force: :cascade do |t|
    t.string "most_recent_job_title"
    t.string "company_name"
    t.text "notice_period"
    t.date "end_date"
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "current_status_employment_types", force: :cascade do |t|
    t.integer "current_status_id"
    t.integer "employment_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "current_status_industries", force: :cascade do |t|
    t.integer "current_status_id"
    t.integer "industry_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "custom_fields", force: :cascade do |t|
    t.string "field_name"
    t.string "data_type"
    t.boolean "mandatory", default: false
    t.string "fieldable_type"
    t.bigint "fieldable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data_type"], name: "index_custom_fields_on_data_type"
    t.index ["field_name"], name: "index_custom_fields_on_field_name"
    t.index ["fieldable_id"], name: "index_custom_fields_on_fieldable_id"
    t.index ["fieldable_type", "fieldable_id"], name: "index_custom_fields_on_fieldable_type_and_fieldable_id"
    t.index ["mandatory"], name: "index_custom_fields_on_mandatory"
  end

  create_table "custom_fields_options", force: :cascade do |t|
    t.string "option_name"
    t.bigint "custom_field_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["custom_field_id"], name: "index_custom_fields_options_on_custom_field_id"
    t.index ["option_name"], name: "index_custom_fields_options_on_option_name"
  end

  create_table "dashboards", force: :cascade do |t|
    t.string "title"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deal_catalogues", force: :cascade do |t|
    t.bigint "deal_id", null: false
    t.bigint "catalogue_id", null: false
    t.integer "status", default: 0
    t.decimal "deal_price", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "seller_id"
    t.string "seller_sku"
    t.string "product_title"
    t.decimal "seller_price", precision: 10, scale: 2, default: "0.0"
    t.decimal "current_offer_price", precision: 10, scale: 2, default: "0.0"
    t.index ["catalogue_id"], name: "index_deal_catalogues_on_catalogue_id"
    t.index ["current_offer_price"], name: "index_deal_catalogues_on_current_offer_price"
    t.index ["deal_id"], name: "index_deal_catalogues_on_deal_id"
    t.index ["deal_price"], name: "index_deal_catalogues_on_deal_price"
    t.index ["product_title"], name: "index_deal_catalogues_on_product_title"
    t.index ["seller_id"], name: "index_deal_catalogues_on_seller_id"
    t.index ["seller_price"], name: "index_deal_catalogues_on_seller_price"
    t.index ["seller_sku"], name: "index_deal_catalogues_on_seller_sku"
    t.index ["status"], name: "index_deal_catalogues_on_status"
  end

  create_table "deals", force: :cascade do |t|
    t.string "deal_name"
    t.string "deal_code"
    t.date "start_date"
    t.date "end_date"
    t.boolean "status", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "discount_type"
    t.decimal "discount_value", precision: 10, scale: 2, default: "0.0"
    t.index ["deal_code"], name: "index_deals_on_deal_code"
    t.index ["deal_name"], name: "index_deals_on_deal_name"
    t.index ["discount_type"], name: "index_deals_on_discount_type"
    t.index ["discount_value"], name: "index_deals_on_discount_value"
    t.index ["end_date"], name: "index_deals_on_end_date"
    t.index ["start_date"], name: "index_deals_on_start_date"
    t.index ["status"], name: "index_deals_on_status"
  end

  create_table "degree_educational_qualifications", force: :cascade do |t|
    t.integer "educational_qualification_id"
    t.integer "degree_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "degrees", force: :cascade do |t|
    t.string "degree_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "delivery_requests", force: :cascade do |t|
    t.bigint "warehouse_id"
    t.string "warehouse_name"
    t.string "order_number"
    t.string "address_1"
    t.string "address_2"
    t.text "geo_location"
    t.string "status"
    t.bigint "seller_id"
    t.bigint "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_delivery_requests_on_order_id"
    t.index ["order_number"], name: "index_delivery_requests_on_order_number"
    t.index ["seller_id"], name: "index_delivery_requests_on_seller_id"
    t.index ["status"], name: "index_delivery_requests_on_status"
    t.index ["warehouse_id"], name: "index_delivery_requests_on_warehouse_id"
    t.index ["warehouse_name"], name: "index_delivery_requests_on_warehouse_name"
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

  create_table "educational_qualification_field_study", force: :cascade do |t|
    t.integer "educational_qualification_id"
    t.integer "field_study_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "educational_qualifications", force: :cascade do |t|
    t.string "school_name"
    t.date "start_date"
    t.date "end_date"
    t.string "grades"
    t.text "description"
    t.boolean "make_grades_public", default: false, null: false
    t.integer "profile_id"
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

  create_table "employment_types", force: :cascade do |t|
    t.string "employment_type_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorite_book_catalogues", force: :cascade do |t|
    t.bigint "author_favorite_book_id", null: false
    t.bigint "catalogue_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_favorite_book_id"], name: "index_favorite_book_catalogues_on_author_favorite_book_id"
    t.index ["catalogue_id"], name: "index_favorite_book_catalogues_on_catalogue_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "favouriteable_id"
    t.string "favouriteable_type"
    t.integer "user_id"
    t.bigint "product_variant_group_id"
    t.index ["favouriteable_id"], name: "index_favourites_on_favouriteable_id"
    t.index ["favouriteable_type"], name: "index_favourites_on_favouriteable_type"
    t.index ["product_variant_group_id"], name: "index_favourites_on_product_variant_group_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "feature_bullets", force: :cascade do |t|
    t.string "field_name"
    t.string "value"
    t.bigint "product_content_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_name"], name: "index_feature_bullets_on_field_name"
    t.index ["product_content_id"], name: "index_feature_bullets_on_product_content_id"
    t.index ["value"], name: "index_feature_bullets_on_value"
  end

  create_table "field_study", force: :cascade do |t|
    t.string "field_of_study"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "gated_brands", force: :cascade do |t|
    t.boolean "approved", default: false
    t.bigint "brand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_gated_brands_on_brand_id"
  end

  create_table "global_settings", force: :cascade do |t|
    t.string "notice_period"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "group_attributes", force: :cascade do |t|
    t.bigint "product_variant_group_id", null: false
    t.string "attribute_name"
    t.string "option"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "variant_attribute_id"
    t.bigint "attribute_option_id"
    t.index ["attribute_name"], name: "index_group_attributes_on_attribute_name"
    t.index ["attribute_option_id"], name: "index_group_attributes_on_attribute_option_id"
    t.index ["option"], name: "index_group_attributes_on_option"
    t.index ["product_variant_group_id"], name: "index_group_attributes_on_product_variant_group_id"
    t.index ["variant_attribute_id"], name: "index_group_attributes_on_variant_attribute_id"
  end

  create_table "header_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.integer "sequence_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_header_categories_on_category_id"
    t.index ["sequence_no"], name: "index_header_categories_on_sequence_no"
  end

  create_table "helpful_reviews", force: :cascade do |t|
    t.bigint "review_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_helpful_reviews_on_customer_id"
    t.index ["review_id", "customer_id"], name: "index_helpful_reviews_on_review_id_and_customer_id", unique: true
    t.index ["review_id"], name: "index_helpful_reviews_on_review_id"
  end

  create_table "hobbies_and_interests", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.text "description"
    t.boolean "make_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "image_urls", force: :cascade do |t|
    t.string "url"
    t.bigint "product_content_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_content_id"], name: "index_image_urls_on_product_content_id"
    t.index ["url"], name: "index_image_urls_on_url"
  end

  create_table "industries", force: :cascade do |t|
    t.string "industry_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoice_billings", force: :cascade do |t|
    t.string "invoice_number"
    t.bigint "order_id", null: false
    t.bigint "order_item_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_invoice_billings_on_customer_id"
    t.index ["invoice_number"], name: "index_invoice_billings_on_invoice_number"
    t.index ["order_id"], name: "index_invoice_billings_on_order_id"
    t.index ["order_item_id"], name: "index_invoice_billings_on_order_item_id"
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

  create_table "languages", force: :cascade do |t|
    t.string "language"
    t.string "proficiency"
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "like_by_id"
    t.string "likeable_type", null: false
    t.bigint "likeable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.integer "van_id"
    t.text "address"
    t.string "locationable_type", null: false
    t.bigint "locationable_id", null: false
    t.index ["locationable_type", "locationable_id"], name: "index_locations_on_locationable_type_and_locationable_id"
  end

  create_table "mall_promo_codes", force: :cascade do |t|
    t.bigint "promo_code_id", null: false
    t.integer "mall_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["promo_code_id"], name: "index_mall_promo_codes_on_promo_code_id"
  end

  create_table "micro_categories", force: :cascade do |t|
    t.string "name"
    t.integer "mini_category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_micro_categories_on_id"
    t.index ["name"], name: "index_micro_categories_on_name"
  end

  create_table "mini_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sub_category_id"
    t.index ["id"], name: "index_mini_categories_on_id"
    t.index ["name"], name: "index_mini_categories_on_name"
  end

  create_table "most_popular_categories", force: :cascade do |t|
    t.integer "sequence_no"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_most_popular_categories_on_category_id"
    t.index ["sequence_no"], name: "index_most_popular_categories_on_sequence_no"
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

  create_table "order_items_return_exchange_requests", id: false, force: :cascade do |t|
    t.bigint "return_exchange_request_id", null: false
    t.bigint "order_item_id", null: false
    t.index ["order_item_id", "return_exchange_request_id"], name: "index_rer_on_oi_id_and_rer_id"
    t.index ["return_exchange_request_id", "order_item_id"], name: "index_rer_on_rer_id_and_oi_id"
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
    t.index ["name"], name: "index_order_statuses_on_name"
    t.index ["status"], name: "index_order_statuses_on_status"
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

  create_table "parent_catalogues", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "brand_id", null: false
    t.string "sku"
    t.string "besku"
    t.string "prod_model_no"
    t.string "details"
    t.boolean "status"
    t.string "product_title"
    t.bigint "sub_category_id"
    t.bigint "mini_category_id"
    t.bigint "micro_category_id"
    t.bigint "admin_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_parent_catalogues_on_admin_id"
    t.index ["besku"], name: "index_parent_catalogues_on_besku"
    t.index ["brand_id"], name: "index_parent_catalogues_on_brand_id"
    t.index ["category_id"], name: "index_parent_catalogues_on_category_id"
    t.index ["details"], name: "index_parent_catalogues_on_details"
    t.index ["micro_category_id"], name: "index_parent_catalogues_on_micro_category_id"
    t.index ["mini_category_id"], name: "index_parent_catalogues_on_mini_category_id"
    t.index ["prod_model_no"], name: "index_parent_catalogues_on_prod_model_no"
    t.index ["product_title"], name: "index_parent_catalogues_on_product_title"
    t.index ["sku"], name: "index_parent_catalogues_on_sku"
    t.index ["sub_category_id"], name: "index_parent_catalogues_on_sub_category_id"
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
    t.string "name", null: false
    t.string "description"
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "body"
    t.string "location"
    t.integer "account_id"
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

  create_table "product_contents", force: :cascade do |t|
    t.string "gtin"
    t.string "unique_psku"
    t.string "brand_name"
    t.string "product_title"
    t.decimal "mrp", precision: 10, scale: 2
    t.decimal "retail_price", precision: 10, scale: 2
    t.text "long_description"
    t.string "whats_in_the_package"
    t.string "country_of_origin"
    t.string "dispenser_type"
    t.string "scent_type"
    t.string "target_use"
    t.string "style_name"
    t.bigint "catalogue_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "product_color"
    t.integer "warranty_days"
    t.integer "warranty_months"
    t.index ["brand_name"], name: "index_product_contents_on_brand_name"
    t.index ["catalogue_id"], name: "index_product_contents_on_catalogue_id"
    t.index ["country_of_origin"], name: "index_product_contents_on_country_of_origin"
    t.index ["gtin"], name: "index_product_contents_on_gtin"
    t.index ["mrp"], name: "index_product_contents_on_mrp"
    t.index ["product_color"], name: "index_product_contents_on_product_color"
    t.index ["product_title"], name: "index_product_contents_on_product_title"
    t.index ["retail_price"], name: "index_product_contents_on_retail_price"
    t.index ["unique_psku"], name: "index_product_contents_on_unique_psku"
    t.index ["warranty_days"], name: "index_product_contents_on_warranty_days"
    t.index ["warranty_months"], name: "index_product_contents_on_warranty_months"
    t.index ["whats_in_the_package"], name: "index_product_contents_on_whats_in_the_package"
  end

  create_table "product_variant_groups", force: :cascade do |t|
    t.string "product_sku"
    t.string "product_description"
    t.decimal "price"
    t.string "product_title"
    t.bigint "catalogue_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "catalogue_variant_id"
    t.string "product_besku"
    t.bigint "variant_product_id"
    t.string "product_bibc"
    t.index ["catalogue_id"], name: "index_product_variant_groups_on_catalogue_id"
    t.index ["catalogue_variant_id"], name: "index_product_variant_groups_on_catalogue_variant_id"
    t.index ["product_besku"], name: "index_product_variant_groups_on_product_besku"
    t.index ["product_bibc"], name: "index_product_variant_groups_on_product_bibc"
    t.index ["product_sku"], name: "index_product_variant_groups_on_product_sku"
    t.index ["product_title"], name: "index_product_variant_groups_on_product_title"
    t.index ["variant_product_id"], name: "index_product_variant_groups_on_variant_product_id"
  end

  create_table "product_views", force: :cascade do |t|
    t.bigint "catalogue_id", null: false
    t.bigint "user_id"
    t.datetime "viewed_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["catalogue_id"], name: "index_product_views_on_catalogue_id"
    t.index ["user_id"], name: "index_product_views_on_user_id"
    t.index ["viewed_at"], name: "index_product_views_on_viewed_at"
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
    t.string "country"
    t.string "address"
    t.string "postal_code"
    t.integer "account_id"
    t.string "photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "profile_role"
    t.string "city"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.date "start_date"
    t.date "end_date"
    t.string "add_members"
    t.string "url"
    t.text "description"
    t.boolean "make_projects_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "promo_codes", force: :cascade do |t|
    t.string "name"
    t.integer "discount_type"
    t.integer "redeem_limit"
    t.text "description"
    t.text "terms_n_condition"
    t.float "max_discount_amount"
    t.float "min_order_amount"
    t.datetime "from"
    t.datetime "to"
    t.integer "status"
    t.float "discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "publication_patents", force: :cascade do |t|
    t.string "title"
    t.string "publication"
    t.string "authors"
    t.string "url"
    t.text "description"
    t.boolean "make_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "requests", force: :cascade do |t|
    t.integer "account_id"
    t.integer "sender_id"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "restaurant_promo_codes", force: :cascade do |t|
    t.bigint "promo_code_id", null: false
    t.integer "restaurant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["promo_code_id"], name: "index_restaurant_promo_codes_on_promo_code_id"
  end

  create_table "restricted_brands", force: :cascade do |t|
    t.boolean "approved", default: false
    t.bigint "brand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "seller_id", null: false
    t.index ["brand_id"], name: "index_restricted_brands_on_brand_id"
    t.index ["seller_id"], name: "index_restricted_brands_on_seller_id"
  end

  create_table "return_exchange_requests", force: :cascade do |t|
    t.string "order_number"
    t.string "request_type"
    t.string "request_reason"
    t.text "description"
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "customer_id"
    t.boolean "status", default: false
    t.string "custom_status"
    t.index ["custom_status"], name: "index_return_exchange_requests_on_custom_status"
    t.index ["customer_id"], name: "index_return_exchange_requests_on_customer_id"
    t.index ["order_id"], name: "index_return_exchange_requests_on_order_id"
    t.index ["order_number"], name: "index_return_exchange_requests_on_order_number"
    t.index ["request_reason"], name: "index_return_exchange_requests_on_request_reason"
    t.index ["request_type"], name: "index_return_exchange_requests_on_request_type"
    t.index ["status"], name: "index_return_exchange_requests_on_status"
  end

  create_table "return_reason_details", force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.bigint "shopping_cart_order_item_id", null: false
    t.integer "reason_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reason_type"], name: "index_return_reason_details_on_reason_type"
    t.index ["shopping_cart_order_item_id"], name: "index_return_reason_details_on_shopping_cart_order_item_id"
    t.index ["title"], name: "index_return_reason_details_on_title"
  end

  create_table "review_and_ratings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "rating", precision: 3, scale: 1
    t.integer "catalogue_id"
    t.integer "reviewer_id"
    t.string "review_type"
    t.integer "account_id"
    t.boolean "is_approved", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_item_id"
    t.index ["account_id"], name: "index_review_and_ratings_on_account_id"
    t.index ["catalogue_id"], name: "index_review_and_ratings_on_catalogue_id"
    t.index ["is_approved"], name: "index_review_and_ratings_on_is_approved"
    t.index ["order_item_id"], name: "index_review_and_ratings_on_order_item_id"
    t.index ["rating"], name: "index_review_and_ratings_on_rating"
    t.index ["review_type"], name: "index_review_and_ratings_on_review_type"
    t.index ["reviewer_id"], name: "index_review_and_ratings_on_reviewer_id"
    t.index ["title"], name: "index_review_and_ratings_on_title"
  end

  create_table "reviews_reviews", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "account_id"
    t.integer "reviewer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "anonymous", default: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "seller_documents", force: :cascade do |t|
    t.string "document_type"
    t.string "document_name"
    t.json "document_files"
    t.string "vat_reason"
    t.string "iban"
    t.string "bank_address"
    t.string "name"
    t.string "bank_name"
    t.string "swift_code"
    t.string "account_no"
    t.boolean "approved"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "rejected"
    t.string "reason_for_rejection"
    t.index ["account_id"], name: "index_seller_documents_on_account_id"
    t.index ["account_no"], name: "index_seller_documents_on_account_no"
    t.index ["approved"], name: "index_seller_documents_on_approved"
    t.index ["bank_address"], name: "index_seller_documents_on_bank_address"
    t.index ["bank_name"], name: "index_seller_documents_on_bank_name"
    t.index ["document_name"], name: "index_seller_documents_on_document_name"
    t.index ["document_type"], name: "index_seller_documents_on_document_type"
    t.index ["iban"], name: "index_seller_documents_on_iban"
    t.index ["name"], name: "index_seller_documents_on_name"
    t.index ["rejected"], name: "index_seller_documents_on_rejected"
    t.index ["swift_code"], name: "index_seller_documents_on_swift_code"
    t.index ["vat_reason"], name: "index_seller_documents_on_vat_reason"
  end

  create_table "seller_static_pages", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.boolean "status", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "section", default: "header"
    t.index ["section"], name: "index_seller_static_pages_on_section"
    t.index ["status"], name: "index_seller_static_pages_on_status"
    t.index ["title"], name: "index_seller_static_pages_on_title"
  end

  create_table "seo_settings", force: :cascade do |t|
    t.string "page_name"
    t.string "meta_title"
    t.string "meta_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "shipped_order_details", force: :cascade do |t|
    t.text "shipping_details"
    t.bigint "order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "courier_name"
    t.string "tracking_number"
    t.integer "order_item_id"
    t.index ["courier_name"], name: "index_shipped_order_details_on_courier_name"
    t.index ["order_id"], name: "index_shipped_order_details_on_order_id"
    t.index ["shipping_details"], name: "index_shipped_order_details_on_shipping_details"
    t.index ["tracking_number"], name: "index_shipped_order_details_on_tracking_number"
  end

  create_table "shipping_details", force: :cascade do |t|
    t.decimal "shipping_length"
    t.string "shipping_length_unit"
    t.decimal "shipping_height"
    t.string "shipping_height_unit"
    t.decimal "shipping_width"
    t.string "shipping_width_unit"
    t.decimal "shipping_weight"
    t.string "shipping_weight_unit"
    t.bigint "product_content_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_content_id"], name: "index_shipping_details_on_product_content_id"
    t.index ["shipping_height"], name: "index_shipping_details_on_shipping_height"
    t.index ["shipping_height_unit"], name: "index_shipping_details_on_shipping_height_unit"
    t.index ["shipping_length"], name: "index_shipping_details_on_shipping_length"
    t.index ["shipping_length_unit"], name: "index_shipping_details_on_shipping_length_unit"
    t.index ["shipping_weight"], name: "index_shipping_details_on_shipping_weight"
    t.index ["shipping_weight_unit"], name: "index_shipping_details_on_shipping_weight_unit"
    t.index ["shipping_width"], name: "index_shipping_details_on_shipping_width"
    t.index ["shipping_width_unit"], name: "index_shipping_details_on_shipping_width_unit"
  end

  create_table "shopping_cart_order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "catalogue_id"
    t.float "price"
    t.integer "quantity", default: 0
    t.boolean "taxable", default: false
    t.float "taxable_value", default: 0.0
    t.float "other_charges"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "discount_price", default: "0.0"
    t.bigint "product_variant_group_id"
    t.bigint "order_status_id"
    t.boolean "accepted", default: false
    t.index ["catalogue_id"], name: "index_shopping_cart_order_items_on_catalogue_id"
    t.index ["discount_price"], name: "index_shopping_cart_order_items_on_discount_price"
    t.index ["order_id"], name: "index_shopping_cart_order_items_on_order_id"
    t.index ["order_status_id"], name: "index_shopping_cart_order_items_on_order_status_id"
    t.index ["price"], name: "index_shopping_cart_order_items_on_price"
    t.index ["product_variant_group_id"], name: "index_shopping_cart_order_items_on_product_variant_group_id"
    t.index ["quantity"], name: "index_shopping_cart_order_items_on_quantity"
  end

  create_table "shopping_cart_orders", force: :cascade do |t|
    t.bigint "customer_id"
    t.integer "address_id"
    t.integer "status"
    t.float "total_fees"
    t.integer "total_items"
    t.float "total_tax"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "final_price"
    t.float "discount", default: 0.0
    t.string "order_number"
    t.bigint "coupon_code_id"
    t.bigint "order_status_id"
    t.datetime "order_placed_at"
    t.datetime "delivered_at"
    t.boolean "accepted", default: false
    t.string "transaction_id"
    t.string "shipping_first_name"
    t.string "shipping_last_name"
    t.string "shipping_address_1"
    t.string "shipping_address_2"
    t.string "shipping_city"
    t.string "shipping_state"
    t.string "shipping_phone_number"
    t.string "shipping_zip_code"
    t.index ["address_id"], name: "index_shopping_cart_orders_on_address_id"
    t.index ["coupon_code_id"], name: "index_shopping_cart_orders_on_coupon_code_id"
    t.index ["customer_id"], name: "index_shopping_cart_orders_on_customer_id"
    t.index ["delivered_at"], name: "index_shopping_cart_orders_on_delivered_at"
    t.index ["final_price"], name: "index_shopping_cart_orders_on_final_price"
    t.index ["order_number"], name: "index_shopping_cart_orders_on_order_number"
    t.index ["order_placed_at"], name: "index_shopping_cart_orders_on_order_placed_at"
    t.index ["order_status_id"], name: "index_shopping_cart_orders_on_order_status_id"
    t.index ["shipping_address_1"], name: "index_shopping_cart_orders_on_shipping_address_1"
    t.index ["shipping_address_2"], name: "index_shopping_cart_orders_on_shipping_address_2"
    t.index ["shipping_city"], name: "index_shopping_cart_orders_on_shipping_city"
    t.index ["shipping_first_name"], name: "index_shopping_cart_orders_on_shipping_first_name"
    t.index ["shipping_last_name"], name: "index_shopping_cart_orders_on_shipping_last_name"
    t.index ["shipping_phone_number"], name: "index_shopping_cart_orders_on_shipping_phone_number"
    t.index ["total_fees"], name: "index_shopping_cart_orders_on_total_fees"
    t.index ["total_items"], name: "index_shopping_cart_orders_on_total_items"
    t.index ["transaction_id"], name: "index_shopping_cart_orders_on_transaction_id"
  end

  create_table "size_and_capacities", force: :cascade do |t|
    t.integer "size"
    t.string "size_unit"
    t.integer "capacity"
    t.string "capacity_unit"
    t.string "hs_code"
    t.string "prod_model_name"
    t.string "prod_model_number"
    t.integer "number_of_pieces"
    t.bigint "product_content_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["capacity"], name: "index_size_and_capacities_on_capacity"
    t.index ["capacity_unit"], name: "index_size_and_capacities_on_capacity_unit"
    t.index ["hs_code"], name: "index_size_and_capacities_on_hs_code"
    t.index ["number_of_pieces"], name: "index_size_and_capacities_on_number_of_pieces"
    t.index ["prod_model_name"], name: "index_size_and_capacities_on_prod_model_name"
    t.index ["prod_model_number"], name: "index_size_and_capacities_on_prod_model_number"
    t.index ["product_content_id"], name: "index_size_and_capacities_on_product_content_id"
    t.index ["size"], name: "index_size_and_capacities_on_size"
    t.index ["size_unit"], name: "index_size_and_capacities_on_size_unit"
  end

  create_table "sms_otps", force: :cascade do |t|
    t.string "full_phone_number"
    t.integer "pin"
    t.boolean "activated", default: false, null: false
    t.datetime "valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activated"], name: "index_sms_otps_on_activated"
    t.index ["full_phone_number"], name: "index_sms_otps_on_full_phone_number"
    t.index ["pin"], name: "index_sms_otps_on_pin"
    t.index ["valid_until"], name: "index_sms_otps_on_valid_until"
  end

  create_table "social_platforms", force: :cascade do |t|
    t.string "social_media"
    t.string "social_media_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["social_media"], name: "index_social_platforms_on_social_media"
    t.index ["social_media_url"], name: "index_social_platforms_on_social_media_url"
  end

  create_table "special_features", force: :cascade do |t|
    t.string "field_name"
    t.string "value"
    t.bigint "product_content_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_name"], name: "index_special_features_on_field_name"
    t.index ["product_content_id"], name: "index_special_features_on_product_content_id"
    t.index ["value"], name: "index_special_features_on_value"
  end

  create_table "static_pages", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["status"], name: "index_static_pages_on_status"
    t.index ["title"], name: "index_static_pages_on_title"
  end

  create_table "stock_intakes", force: :cascade do |t|
    t.bigint "catalogue_id", null: false
    t.bigint "seller_id", null: false
    t.decimal "stock_value"
    t.integer "stock_qty"
    t.datetime "ship_date"
    t.datetime "receiving_date"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["catalogue_id"], name: "index_stock_intakes_on_catalogue_id"
    t.index ["seller_id"], name: "index_stock_intakes_on_seller_id"
  end

  create_table "store_dashboard_sections", force: :cascade do |t|
    t.string "section_name"
    t.string "section_type"
    t.string "banner_name"
    t.string "banner_url"
    t.bigint "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["banner_name"], name: "index_store_dashboard_sections_on_banner_name"
    t.index ["banner_url"], name: "index_store_dashboard_sections_on_banner_url"
    t.index ["section_name"], name: "index_store_dashboard_sections_on_section_name"
    t.index ["section_type"], name: "index_store_dashboard_sections_on_section_type"
    t.index ["store_id"], name: "index_store_dashboard_sections_on_store_id"
  end

  create_table "store_menus", force: :cascade do |t|
    t.string "title"
    t.string "store_name"
    t.bigint "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "banner_name"
    t.integer "position", default: 1
    t.integer "product_quantity"
    t.index ["banner_name"], name: "index_store_menus_on_banner_name"
    t.index ["position"], name: "index_store_menus_on_position"
    t.index ["product_quantity"], name: "index_store_menus_on_product_quantity"
    t.index ["store_id"], name: "index_store_menus_on_store_id"
    t.index ["store_name"], name: "index_store_menus_on_store_name"
    t.index ["title"], name: "index_store_menus_on_title"
  end

  create_table "store_section_grids", force: :cascade do |t|
    t.string "grid_name"
    t.string "grid_no"
    t.string "grid_url"
    t.bigint "store_dashboard_section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grid_name"], name: "index_store_section_grids_on_grid_name"
    t.index ["grid_no"], name: "index_store_section_grids_on_grid_no"
    t.index ["grid_url"], name: "index_store_section_grids_on_grid_url"
    t.index ["store_dashboard_section_id"], name: "index_store_section_grids_on_store_dashboard_section_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "store_name"
    t.integer "store_year"
    t.string "store_url"
    t.string "website_social_url"
    t.bigint "brand_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approve"
    t.integer "account_id"
    t.index ["account_id"], name: "index_stores_on_account_id"
    t.index ["approve"], name: "index_stores_on_approve"
    t.index ["brand_id"], name: "index_stores_on_brand_id"
    t.index ["store_name"], name: "index_stores_on_store_name"
    t.index ["store_url"], name: "index_stores_on_store_url"
    t.index ["store_year"], name: "index_stores_on_store_year"
    t.index ["website_social_url"], name: "index_stores_on_website_social_url"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_id"
    t.integer "rank"
    t.index ["name"], name: "index_sub_categories_on_name"
  end

  create_table "subscribe_coupons", force: :cascade do |t|
    t.integer "account_id"
    t.integer "coupon_code_id"
    t.integer "catalogue_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "suggestion_feedbacks", force: :cascade do |t|
    t.string "detail_type"
    t.string "detail"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_suggestion_feedbacks_on_account_id"
    t.index ["detail_type"], name: "index_suggestion_feedbacks_on_detail_type"
    t.index ["email"], name: "index_suggestion_feedbacks_on_email"
    t.index ["first_name"], name: "index_suggestion_feedbacks_on_first_name"
    t.index ["last_name"], name: "index_suggestion_feedbacks_on_last_name"
  end

  create_table "support_documents", force: :cascade do |t|
    t.string "page_title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_title"], name: "index_support_documents_on_page_title"
  end

  create_table "supports", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.text "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_supports_on_email"
    t.index ["first_name"], name: "index_supports_on_first_name"
    t.index ["last_name"], name: "index_supports_on_last_name"
  end

  create_table "system_experiences", force: :cascade do |t|
    t.string "system_experience"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "terms_policies", force: :cascade do |t|
    t.string "page_title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_title"], name: "index_terms_policies_on_page_title"
  end

  create_table "test_score_and_courses", force: :cascade do |t|
    t.string "title"
    t.string "associated_with"
    t.string "score"
    t.datetime "test_date"
    t.text "description"
    t.boolean "make_public", default: false, null: false
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "top_brands", force: :cascade do |t|
    t.integer "sequence_no"
    t.bigint "brand_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_top_brands_on_brand_id"
    t.index ["sequence_no"], name: "index_top_brands_on_sequence_no"
  end

  create_table "trackings", force: :cascade do |t|
    t.string "status"
    t.string "tracking_number"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trending_product_selections", force: :cascade do |t|
    t.bigint "trending_product_id", null: false
    t.bigint "catalogue_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["catalogue_id"], name: "index_trending_product_selections_on_catalogue_id"
    t.index ["trending_product_id"], name: "index_trending_product_selections_on_trending_product_id"
  end

  create_table "trending_products", force: :cascade do |t|
    t.integer "slider"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slider"], name: "index_trending_products_on_slider"
  end

  create_table "user_categories", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_user_categories_on_account_id"
    t.index ["category_id"], name: "index_user_categories_on_category_id"
  end

  create_table "user_delivery_addresses", force: :cascade do |t|
    t.string "city"
    t.boolean "is_default", default: false
    t.string "address_type"
    t.string "state"
    t.bigint "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address_1"
    t.string "address_2"
    t.string "phone_number"
    t.string "zip_code"
    t.index ["account_id"], name: "index_user_delivery_addresses_on_account_id"
    t.index ["address_1"], name: "index_user_delivery_addresses_on_address_1"
    t.index ["address_2"], name: "index_user_delivery_addresses_on_address_2"
    t.index ["city"], name: "index_user_delivery_addresses_on_city"
    t.index ["first_name"], name: "index_user_delivery_addresses_on_first_name"
    t.index ["is_default"], name: "index_user_delivery_addresses_on_is_default"
    t.index ["last_name"], name: "index_user_delivery_addresses_on_last_name"
    t.index ["phone_number"], name: "index_user_delivery_addresses_on_phone_number"
    t.index ["state"], name: "index_user_delivery_addresses_on_state"
    t.index ["zip_code"], name: "index_user_delivery_addresses_on_zip_code"
  end

  create_table "user_sub_categories", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "sub_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_user_sub_categories_on_account_id"
    t.index ["sub_category_id"], name: "index_user_sub_categories_on_sub_category_id"
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

  create_table "variant_attributes", force: :cascade do |t|
    t.string "attribute_name"
    t.bigint "catalogue_variant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attribute_name"], name: "index_variant_attributes_on_attribute_name"
    t.index ["catalogue_variant_id"], name: "index_variant_attributes_on_catalogue_variant_id"
  end

  create_table "view_profiles", force: :cascade do |t|
    t.integer "profile_bio_id"
    t.integer "view_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "account_id"
  end

  create_table "warehouse_catalogues", force: :cascade do |t|
    t.bigint "warehouse_id", null: false
    t.bigint "catalogue_id", null: false
    t.bigint "product_variant_group_id"
    t.integer "stocks", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["catalogue_id"], name: "index_warehouse_catalogues_on_catalogue_id"
    t.index ["product_variant_group_id"], name: "index_warehouse_catalogues_on_product_variant_group_id"
    t.index ["stocks"], name: "index_warehouse_catalogues_on_stocks"
    t.index ["warehouse_id"], name: "index_warehouse_catalogues_on_warehouse_id"
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "warehouse_type"
    t.string "warehouse_name"
    t.string "warehouse_address_1"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "contact_number"
    t.string "contact_person"
    t.integer "processing_days"
    t.integer "account_id"
    t.string "warehouse_address_2"
    t.string "warehouse_code"
    t.index ["account_id"], name: "index_warehouses_on_account_id"
    t.index ["contact_number"], name: "index_warehouses_on_contact_number"
    t.index ["contact_person"], name: "index_warehouses_on_contact_person"
    t.index ["processing_days"], name: "index_warehouses_on_processing_days"
    t.index ["warehouse_address_1"], name: "index_warehouses_on_warehouse_address_1"
    t.index ["warehouse_address_2"], name: "index_warehouses_on_warehouse_address_2"
    t.index ["warehouse_name"], name: "index_warehouses_on_warehouse_name"
    t.index ["warehouse_type"], name: "index_warehouses_on_warehouse_type"
  end

  create_table "weekly_deals", force: :cascade do |t|
    t.bigint "weekly_homiee_deal_id", null: false
    t.string "caption"
    t.decimal "discount_percent", precision: 5, scale: 2
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "deal_id"
    t.index ["caption"], name: "index_weekly_deals_on_caption"
    t.index ["deal_id"], name: "index_weekly_deals_on_deal_id"
    t.index ["discount_percent"], name: "index_weekly_deals_on_discount_percent"
    t.index ["url"], name: "index_weekly_deals_on_url"
    t.index ["weekly_homiee_deal_id"], name: "index_weekly_deals_on_weekly_homiee_deal_id"
  end

  create_table "weekly_homiee_deals", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "status", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_time"], name: "index_weekly_homiee_deals_on_end_time"
    t.index ["start_time"], name: "index_weekly_homiee_deals_on_start_time"
    t.index ["status"], name: "index_weekly_homiee_deals_on_status"
  end

  create_table "wms_consignment_orders", force: :cascade do |t|
    t.string "order_number"
    t.bigint "seller_id", null: false
    t.bigint "catalogue_id", null: false
    t.integer "quantity"
    t.decimal "unit_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["catalogue_id"], name: "index_wms_consignment_orders_on_catalogue_id"
    t.index ["order_number"], name: "index_wms_consignment_orders_on_order_number"
    t.index ["quantity"], name: "index_wms_consignment_orders_on_quantity"
    t.index ["seller_id"], name: "index_wms_consignment_orders_on_seller_id"
    t.index ["unit_price"], name: "index_wms_consignment_orders_on_unit_price"
  end

  create_table "wms_event_updates", force: :cascade do |t|
    t.string "warehouse_code"
    t.string "seller_email"
    t.string "consignment_type"
    t.string "shipment_number"
    t.string "po_number"
    t.string "old_state"
    t.string "new_state"
    t.datetime "event_on"
    t.string "time_zone"
    t.json "products"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wms_product_infos", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.bigint "catalogue_id", null: false
    t.string "product_information_id"
    t.string "product_dimensions_info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["catalogue_id"], name: "index_wms_product_infos_on_catalogue_id"
    t.index ["product_dimensions_info"], name: "index_wms_product_infos_on_product_dimensions_info"
    t.index ["product_information_id"], name: "index_wms_product_infos_on_product_information_id"
    t.index ["seller_id"], name: "index_wms_product_infos_on_seller_id"
  end

  add_foreign_key "account_promo_codes", "accounts"
  add_foreign_key "account_promo_codes", "promo_codes"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activity_logs", "accounts", column: "user_id", on_delete: :nullify
  add_foreign_key "addressables", "shipments"
  add_foreign_key "attachments", "accounts"
  add_foreign_key "attribute_options", "variant_attributes", on_delete: :cascade
  add_foreign_key "banners", "banner_groups"
  add_foreign_key "banners", "catalogues"
  add_foreign_key "banners", "categories"
  add_foreign_key "banners", "deals"
  add_foreign_key "banners", "sub_categories"
  add_foreign_key "barcodes", "catalogues", on_delete: :cascade
  add_foreign_key "black_list_users", "accounts"
  add_foreign_key "catalogue_contents", "catalogues", on_delete: :cascade
  add_foreign_key "catalogue_contents", "custom_fields"
  add_foreign_key "catalogue_offers", "catalogues", on_delete: :cascade
  add_foreign_key "catalogue_reviews", "catalogues"
  add_foreign_key "catalogue_variants", "accounts", column: "seller_id"
  add_foreign_key "catalogues", "brands"
  add_foreign_key "catalogues", "categories"
  add_foreign_key "catalogues", "parent_catalogues", on_delete: :cascade
  add_foreign_key "catalogues_tags", "catalogue_tags"
  add_foreign_key "catalogues_tags", "catalogues"
  add_foreign_key "chat_messages", "accounts"
  add_foreign_key "chat_messages", "chats"
  add_foreign_key "cod_values", "shipments"
  add_foreign_key "comments", "accounts"
  add_foreign_key "custom_fields_options", "custom_fields"
  add_foreign_key "deal_catalogues", "catalogues", on_delete: :cascade
  add_foreign_key "deal_catalogues", "deals"
  add_foreign_key "deliveries", "shipments"
  add_foreign_key "delivery_address_orders", "delivery_addresses"
  add_foreign_key "delivery_address_orders", "order_management_orders"
  add_foreign_key "delivery_addresses", "accounts"
  add_foreign_key "dimensions", "items"
  add_foreign_key "email_notifications", "notifications"
  add_foreign_key "favorite_book_catalogues", "author_favorite_books"
  add_foreign_key "favorite_book_catalogues", "catalogues"
  add_foreign_key "favourites", "product_variant_groups", on_delete: :cascade
  add_foreign_key "feature_bullets", "product_contents", on_delete: :cascade
  add_foreign_key "gated_brands", "brands"
  add_foreign_key "group_attributes", "product_variant_groups", on_delete: :cascade
  add_foreign_key "header_categories", "categories"
  add_foreign_key "helpful_reviews", "accounts", column: "customer_id"
  add_foreign_key "helpful_reviews", "review_and_ratings", column: "review_id"
  add_foreign_key "image_urls", "product_contents", on_delete: :cascade
  add_foreign_key "invoice_billings", "accounts", column: "customer_id"
  add_foreign_key "invoice_billings", "shopping_cart_order_items", column: "order_item_id"
  add_foreign_key "invoice_billings", "shopping_cart_orders", column: "order_id"
  add_foreign_key "items", "shipments"
  add_foreign_key "mall_promo_codes", "promo_codes"
  add_foreign_key "micro_categories", "mini_categories", on_delete: :cascade
  add_foreign_key "mini_categories", "sub_categories", on_delete: :cascade
  add_foreign_key "most_popular_categories", "categories"
  add_foreign_key "notifications", "accounts"
  add_foreign_key "order_items", "catalogue_variants"
  add_foreign_key "order_items", "catalogues"
  add_foreign_key "order_items", "order_management_orders"
  add_foreign_key "order_transactions", "accounts"
  add_foreign_key "order_transactions", "order_management_orders"
  add_foreign_key "pickups", "shipments"
  add_foreign_key "posts", "categories"
  add_foreign_key "product_contents", "catalogues", on_delete: :cascade
  add_foreign_key "product_variant_groups", "catalogues", on_delete: :cascade
  add_foreign_key "product_views", "accounts", column: "user_id"
  add_foreign_key "product_views", "catalogues"
  add_foreign_key "push_notifications", "accounts"
  add_foreign_key "restaurant_promo_codes", "promo_codes"
  add_foreign_key "restricted_brands", "accounts", column: "seller_id"
  add_foreign_key "restricted_brands", "brands"
  add_foreign_key "return_exchange_requests", "accounts", column: "customer_id"
  add_foreign_key "return_exchange_requests", "shopping_cart_orders", column: "order_id"
  add_foreign_key "return_reason_details", "shopping_cart_order_items"
  add_foreign_key "seller_accounts", "accounts"
  add_foreign_key "seller_documents", "accounts"
  add_foreign_key "shipment_values", "shipments"
  add_foreign_key "shipments", "create_shipments"
  add_foreign_key "shipped_order_details", "shopping_cart_orders", column: "order_id"
  add_foreign_key "shipping_details", "product_contents", on_delete: :cascade
  add_foreign_key "shopping_cart_order_items", "order_statuses"
  add_foreign_key "shopping_cart_order_items", "product_variant_groups", on_delete: :cascade
  add_foreign_key "size_and_capacities", "product_contents", on_delete: :cascade
  add_foreign_key "special_features", "product_contents", on_delete: :cascade
  add_foreign_key "stock_intakes", "accounts", column: "seller_id"
  add_foreign_key "stock_intakes", "catalogues"
  add_foreign_key "store_dashboard_sections", "stores"
  add_foreign_key "store_menus", "stores"
  add_foreign_key "store_section_grids", "store_dashboard_sections"
  add_foreign_key "sub_categories", "categories", column: "parent_id", on_delete: :cascade
  add_foreign_key "top_brands", "brands"
  add_foreign_key "trending_product_selections", "catalogues"
  add_foreign_key "trending_product_selections", "trending_products"
  add_foreign_key "user_categories", "accounts"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_delivery_addresses", "accounts"
  add_foreign_key "user_sub_categories", "accounts"
  add_foreign_key "user_sub_categories", "sub_categories"
  add_foreign_key "variant_attributes", "catalogue_variants", on_delete: :cascade
  add_foreign_key "warehouse_catalogues", "catalogues"
  add_foreign_key "warehouse_catalogues", "product_variant_groups"
  add_foreign_key "warehouse_catalogues", "warehouses"
  add_foreign_key "weekly_deals", "deals"
  add_foreign_key "weekly_deals", "weekly_homiee_deals"
  add_foreign_key "wms_consignment_orders", "accounts", column: "seller_id"
  add_foreign_key "wms_consignment_orders", "catalogues"
  add_foreign_key "wms_product_infos", "accounts", column: "seller_id"
  add_foreign_key "wms_product_infos", "catalogues"
end
