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

ActiveRecord::Schema.define(version: 20170601151321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attributes", force: :cascade do |t|
    t.string   "name",                       null: false
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name"], name: "attributes_business_index", unique: true, using: :btree
  end

  create_table "attributes_products", force: :cascade do |t|
    t.boolean  "deleted",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "attribute_id",                 null: false
    t.integer  "product_id",                   null: false
    t.string   "value"
    t.index ["attribute_id", "product_id"], name: "attributes_products_business_index", unique: true, using: :btree
    t.index ["attribute_id"], name: "index_attributes_products_on_attribute_id", using: :btree
    t.index ["product_id"], name: "index_attributes_products_on_product_id", using: :btree
  end

  create_table "attributes_promotions", force: :cascade do |t|
    t.boolean  "deleted",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "attribute_id",                 null: false
    t.integer  "promotion_id",                 null: false
    t.string   "value"
    t.index ["attribute_id", "promotion_id"], name: "attributes_promotions_business_index", unique: true, using: :btree
    t.index ["attribute_id"], name: "index_attributes_promotions_on_attribute_id", using: :btree
    t.index ["promotion_id"], name: "index_attributes_promotions_on_promotion_id", using: :btree
  end

  create_table "branch_types", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "marker_url",                 null: false
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name"], name: "branch_types_business_index", unique: true, using: :btree
  end

  create_table "branches", force: :cascade do |t|
    t.string   "name",                                   null: false
    t.string   "phone1"
    t.string   "phone2"
    t.string   "address"
    t.boolean  "will_contact",                           null: false
    t.string   "booking_url"
    t.string   "scraper_model"
    t.boolean  "deleted",                default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "shop_id",                                null: false
    t.integer  "commune_id"
    t.string   "street_address"
    t.string   "number_address"
    t.string   "ref_address"
    t.string   "email"
    t.integer  "branch_type_id"
    t.integer  "plan_id"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "interval_between_jumps"
    t.index ["branch_type_id"], name: "index_branches_on_branch_type_id", using: :btree
    t.index ["name"], name: "branches_business_index", unique: true, using: :btree
    t.index ["plan_id"], name: "index_branches_on_plan_id", using: :btree
    t.index ["shop_id"], name: "index_branches_on_shop_id", using: :btree
  end

  create_table "branches_products", force: :cascade do |t|
    t.float    "price"
    t.date     "from_date"
    t.date     "to_date"
    t.boolean  "status",                     null: false
    t.integer  "stock"
    t.string   "url"
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "branch_id",                  null: false
    t.integer  "product_id",                 null: false
    t.index ["branch_id", "product_id"], name: "branches_products_business_index", unique: true, using: :btree
    t.index ["branch_id"], name: "index_branches_products_on_branch_id", using: :btree
    t.index ["product_id"], name: "index_branches_products_on_product_id", using: :btree
  end

  create_table "branches_promotions", force: :cascade do |t|
    t.boolean  "deleted",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "branch_id"
    t.integer  "promotion_id",                 null: false
    t.index ["branch_id", "promotion_id"], name: "branches_promotions_business_index", unique: true, using: :btree
    t.index ["branch_id"], name: "index_branches_promotions_on_branch_id", using: :btree
    t.index ["promotion_id"], name: "index_branches_promotions_on_promotion_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",                           null: false
    t.boolean  "deleted",        default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "parent_id"
    t.integer  "lft",                            null: false
    t.integer  "rgt",                            null: false
    t.integer  "depth",          default: 0,     null: false
    t.integer  "children_count", default: 0,     null: false
    t.string   "slug"
    t.index ["name"], name: "categories_business_index", unique: true, using: :btree
    t.index ["slug"], name: "index_categories_on_slug", using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "primary_last_name"
    t.string   "email",                             null: false
    t.string   "phone"
    t.string   "rut"
    t.integer  "comune_id"
    t.string   "rvm_id",                                         comment: "is the *patente* on the rvm table"
    t.boolean  "deleted",           default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["email", "rvm_id"], name: "clients_business_index", unique: true, using: :btree
  end

  create_table "comuna", primary_key: "id_comuna", id: :integer, force: :cascade do |t|
    t.text    "desc_comuna",               null: false
    t.integer "estado_comuna", default: 1, null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.date     "date",                         null: false
    t.float    "price"
    t.boolean  "deleted",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "promotion_id",                 null: false
    t.integer  "client_id",                    null: false
    t.index ["client_id"], name: "index_coupons_on_client_id", using: :btree
    t.index ["promotion_id"], name: "index_coupons_on_promotion_id", using: :btree
  end

  create_table "marca", primary_key: "id_marca", id: :integer, force: :cascade do |t|
    t.text    "descripcion",              null: false
    t.integer "marca_estado", default: 1, null: false
  end

  create_table "mm_accesos_app", primary_key: "id_mm_accesos", id: :bigint, force: :cascade do |t|
    t.text     "ip_acceso",                                 null: false
    t.bigint   "contador_accesos",                          null: false
    t.datetime "fecha_acceso",     default: -> { "now()" }, null: false
  end

  create_table "mm_alternativas_encuesta", primary_key: "id_alternativas_enc", id: :integer, force: :cascade do |t|
    t.text    "desc_alternativas_enc",               null: false
    t.integer "estado_alternativas_enc", default: 1, null: false
  end

  create_table "mm_parametros", primary_key: "id_mm_parametro", id: :integer, force: :cascade do |t|
    t.text "mm_parametro_descripcion", null: false
    t.text "mm_parametro_valor",       null: false
  end

  create_table "modelo", primary_key: "id_modelo", id: :integer, force: :cascade do |t|
    t.text    "modelo_descripcion",             null: false
    t.integer "id_marca",                       null: false
    t.integer "modelo_estado",      default: 1, null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name",                        null: false
    t.string   "description"
    t.boolean  "deleted",     default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["name"], name: "plans_business_index", unique: true, using: :btree
  end

  create_table "product_brands", force: :cascade do |t|
    t.string   "name"
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name"], name: "product_brands_business_index", unique: true, using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",                             null: false
    t.boolean  "deleted",          default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "category_id",                      null: false
    t.integer  "product_brand_id",                 null: false
    t.string   "slug"
    t.boolean  "status"
    t.string   "image_url"
    t.float    "price"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["name"], name: "products_business_index", unique: true, using: :btree
    t.index ["product_brand_id"], name: "index_products_on_product_brand_id", using: :btree
    t.index ["slug"], name: "index_products_on_slug", using: :btree
  end

  create_table "products_vmes", force: :cascade do |t|
    t.float    "vme_id"
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "product_id",                 null: false
    t.integer  "from_year"
    t.integer  "to_year"
    t.index ["product_id", "vme_id"], name: "products_vmes_business_index", unique: true, using: :btree
    t.index ["product_id"], name: "index_products_vmes_on_product_id", using: :btree
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "description"
    t.date     "from_date"
    t.date     "to_date"
    t.boolean  "status",                              null: false
    t.float    "full_price"
    t.float    "promo_price"
    t.float    "discount_percentage"
    t.integer  "priority",                            null: false
    t.integer  "max_coupons"
    t.boolean  "deleted",             default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "category_id",                         null: false
    t.text     "preview_text"
    t.string   "image_url"
    t.string   "slug"
    t.string   "type"
    t.integer  "kms"
    t.index ["category_id"], name: "index_promotions_on_category_id", using: :btree
    t.index ["name"], name: "promotions_business_index", unique: true, using: :btree
    t.index ["slug"], name: "index_promotions_on_slug", using: :btree
    t.index ["type"], name: "index_promotions_on_type", using: :btree
  end

  create_table "promotions_vmes", force: :cascade do |t|
    t.float    "vme_id"
    t.boolean  "deleted",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "promotion_id",                 null: false
    t.integer  "from_year"
    t.integer  "to_year"
    t.index ["promotion_id", "vme_id"], name: "promotions_vmes_business_index", unique: true, using: :btree
    t.index ["promotion_id"], name: "index_promotions_vmes_on_promotion_id", using: :btree
  end

  create_table "proveedor_taller", primary_key: "ide_rut", id: :integer, force: :cascade, comment: "Rut taller" do |t|
    t.string  "ide_dv",        limit: 1,               null: false
    t.text    "ide_nombre_rz",                         null: false
    t.integer "ide_estado",              default: 1,   null: false
    t.text    "ide_alias",               default: " ", null: false
  end

  create_table "rvm", primary_key: "v_rvm", id: :text, force: :cascade do |t|
    t.text    "v_tipo"
    t.text    "v_marca"
    t.text    "v_modelo"
    t.text    "v_color"
    t.text    "v_motor"
    t.text    "v_chasis"
    t.integer "v_ano_fab"
    t.integer "v_pro_rut"
    t.text    "v_pro_dv"
    t.text    "v_pro_nombre"
    t.index ["v_rvm"], name: "index_v_rvm", using: :btree
  end

  create_table "search_category_settings", force: :cascade do |t|
    t.integer  "filter_type",  null: false
    t.integer  "position"
    t.boolean  "deleted"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "category_id",  null: false
    t.integer  "attribute_id", null: false
    t.index ["attribute_id"], name: "index_search_category_settings_on_attribute_id", using: :btree
    t.index ["category_id", "attribute_id"], name: "search_category_settings_business_index", unique: true, using: :btree
    t.index ["category_id"], name: "index_search_category_settings_on_category_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "shop_inscriptions", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "primary_last_name"
    t.string   "email",                             null: false
    t.string   "phone"
    t.string   "rut"
    t.integer  "comune_id",                         null: false
    t.boolean  "deleted",           default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "company_name"
    t.string   "company_rut"
    t.index ["email"], name: "shop_inscriptions_business_index", unique: true, using: :btree
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "rut",                        null: false
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "email"
    t.boolean  "status",     default: false
    t.string   "image_url"
    t.index ["name"], name: "shops_business_index", unique: true, using: :btree
    t.index ["rut"], name: "index_shops_on_rut", unique: true, using: :btree
  end

  create_table "system_settings", force: :cascade do |t|
    t.integer  "product_scraping_caching_minutes", null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.float    "default_latitude"
    t.float    "default_longitude"
    t.integer  "default_zoom"
  end

  create_table "tipo_seccion", primary_key: "id_tiposeccion", id: :integer, force: :cascade do |t|
    t.text    "descripcion",                     null: false
    t.integer "tiposeccion_estado",  default: 1, null: false
    t.text    "tiposeccion_url_img"
  end

  create_table "tipo_vehiculo", primary_key: "tv_id", id: :integer, force: :cascade do |t|
    t.text    "tv_descripcion",             null: false
    t.integer "tv_estado",      default: 1, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "vehiculo_modelo_especifico", primary_key: "vme_id", id: :float, force: :cascade do |t|
    t.integer "id_modelo",                      null: false
    t.integer "tv_id",                          null: false
    t.text    "vme_mod_especifico",             null: false
    t.integer "vme_estado",         default: 1, null: false
  end

  add_foreign_key "attributes_products", "attributes"
  add_foreign_key "attributes_products", "products"
  add_foreign_key "attributes_promotions", "attributes"
  add_foreign_key "attributes_promotions", "promotions"
  add_foreign_key "branches", "branch_types"
  add_foreign_key "branches", "comuna", column: "commune_id", primary_key: "id_comuna"
  add_foreign_key "branches", "plans"
  add_foreign_key "branches", "shops"
  add_foreign_key "branches_products", "branches"
  add_foreign_key "branches_products", "products"
  add_foreign_key "branches_promotions", "branches"
  add_foreign_key "branches_promotions", "promotions"
  add_foreign_key "clients", "comuna", column: "comune_id", primary_key: "id_comuna"
  add_foreign_key "clients", "rvm", primary_key: "v_rvm"
  add_foreign_key "coupons", "clients"
  add_foreign_key "coupons", "promotions"
  add_foreign_key "modelo", "marca", column: "id_marca", primary_key: "id_marca", name: "fk_marca"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "product_brands"
  add_foreign_key "products_vmes", "products"
  add_foreign_key "products_vmes", "vehiculo_modelo_especifico", column: "vme_id", primary_key: "vme_id"
  add_foreign_key "promotions", "categories"
  add_foreign_key "promotions_vmes", "promotions"
  add_foreign_key "promotions_vmes", "vehiculo_modelo_especifico", column: "vme_id", primary_key: "vme_id"
  add_foreign_key "search_category_settings", "attributes"
  add_foreign_key "search_category_settings", "categories"
  add_foreign_key "shop_inscriptions", "comuna", column: "comune_id", primary_key: "id_comuna"
  add_foreign_key "vehiculo_modelo_especifico", "modelo", column: "id_modelo", primary_key: "id_modelo", name: "fk_modelo"
  add_foreign_key "vehiculo_modelo_especifico", "tipo_vehiculo", column: "tv_id", primary_key: "tv_id", name: "fk_tipo_vehiculo"
end
