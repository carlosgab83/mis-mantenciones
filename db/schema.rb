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

ActiveRecord::Schema.define(version: 20161029204902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attributes", force: :cascade do |t|
    t.string   "name",                       null: false
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name", "deleted"], name: "index_attributes_on_name_and_deleted", unique: true, using: :btree
  end

  create_table "attributes_products", force: :cascade do |t|
    t.boolean  "deleted",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "attribute_id",                 null: false
    t.integer  "product_id",                   null: false
    t.index ["attribute_id"], name: "index_attributes_products_on_attribute_id", using: :btree
    t.index ["product_id"], name: "index_attributes_products_on_product_id", using: :btree
  end

  create_table "branches", force: :cascade do |t|
    t.string   "name",                          null: false
    t.string   "phone1"
    t.string   "phone2"
    t.string   "address"
    t.boolean  "will_contact",                  null: false
    t.string   "booking_url"
    t.string   "scraper_model"
    t.boolean  "deleted",       default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "shop_id",                       null: false
    t.index ["name", "deleted"], name: "index_branches_on_name_and_deleted", unique: true, using: :btree
    t.index ["shop_id"], name: "index_branches_on_shop_id", using: :btree
  end

  create_table "branches_manteinance_items", force: :cascade do |t|
    t.integer  "manteinance_item_id",                 null: false
    t.integer  "pauta_id",                            null: false
    t.float    "full_price",                          null: false
    t.float    "promo_price",                         null: false
    t.float    "discount_percentage"
    t.boolean  "deleted",             default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "branch_id",                           null: false
    t.index ["branch_id"], name: "index_branches_manteinance_items_on_branch_id", using: :btree
  end

  create_table "branches_products", force: :cascade do |t|
    t.float    "price",                      null: false
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
    t.index ["branch_id"], name: "index_branches_products_on_branch_id", using: :btree
    t.index ["product_id"], name: "index_branches_products_on_product_id", using: :btree
  end

  create_table "branches_promotions", force: :cascade do |t|
    t.boolean  "deleted",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "branch_id"
    t.integer  "promotion_id",                 null: false
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
    t.index ["name", "deleted"], name: "index_categories_on_name_and_deleted", unique: true, using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "primary_last_name"
    t.string   "email",                             null: false
    t.string   "phone"
    t.string   "rut"
    t.integer  "comune_id",                         null: false
    t.string   "rvm_id",                                         comment: "is the *patente* on the rvm table"
    t.boolean  "deleted",           default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["email", "rvm_id", "deleted"], name: "index_clients_on_email_and_rvm_id_and_deleted", unique: true, using: :btree
  end

  create_table "comuna", primary_key: "id_comuna", id: :integer, force: :cascade do |t|
    t.text    "desc_comuna",               null: false
    t.integer "estado_comuna", default: 1, null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.date     "date",                         null: false
    t.float    "price",                        null: false
    t.boolean  "deleted",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "promotion_id",                 null: false
    t.integer  "client_id",                    null: false
    t.index ["client_id"], name: "index_coupons_on_client_id", using: :btree
    t.index ["promotion_id"], name: "index_coupons_on_promotion_id", using: :btree
  end

# Could not dump table "envios_mail_cliente" because of following StandardError
#   Unknown type 'time with time zone' for column 'hora_envio'

# Could not dump table "ingresos" because of following StandardError
#   Unknown type 'time with time zone' for column 'hora_ingreso'

  create_table "item_mantencion", primary_key: "id_item_mantencion", id: :integer, force: :cascade do |t|
    t.text    "desc_mantencion", null: false
    t.integer "id_tipo_seccion", null: false
    t.index ["id_tipo_seccion"], name: "idx_item_seccion", using: :btree
  end

  create_table "manteinance_coupons", force: :cascade do |t|
    t.float    "price",                      null: false
    t.date     "date",                       null: false
    t.integer  "pauta_id",                   null: false
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "branch_id",                  null: false
    t.integer  "client_id",                  null: false
    t.index ["branch_id"], name: "index_manteinance_coupons_on_branch_id", using: :btree
    t.index ["client_id"], name: "index_manteinance_coupons_on_client_id", using: :btree
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

  create_table "pauta", primary_key: "id_pauta", id: :integer, force: :cascade do |t|
    t.text    "pauta_descripcion", null: false
    t.integer "kilometraje",       null: false
    t.integer "id_marca"
    t.integer "id_modelo"
    t.text    "url_logo"
  end

  create_table "pauta_detalle", primary_key: ["id_pauta", "id_item_mantencion"], force: :cascade do |t|
    t.integer "id_pauta",           null: false
    t.integer "id_item_mantencion", null: false
  end

  create_table "pauta_proveedor", primary_key: ["id_pauta", "ide_rut", "suc_id"], force: :cascade do |t|
    t.integer "id_pauta",        null: false
    t.integer "ide_rut",         null: false
    t.integer "suc_id",          null: false
    t.decimal "valor"
    t.decimal "valor_descuento"
    t.decimal "porcentaje"
  end

  create_table "product_brands", force: :cascade do |t|
    t.string   "name"
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name", "deleted"], name: "index_product_brands_on_name_and_deleted", unique: true, using: :btree
  end

  create_table "product_types", force: :cascade do |t|
    t.string   "name",                       null: false
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name", "deleted"], name: "index_product_types_on_name_and_deleted", unique: true, using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",                             null: false
    t.boolean  "deleted",          default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "category_id",                      null: false
    t.integer  "product_type_id",                  null: false
    t.integer  "product_brand_id",                 null: false
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["name", "deleted"], name: "index_products_on_name_and_deleted", unique: true, using: :btree
    t.index ["product_brand_id"], name: "index_products_on_product_brand_id", using: :btree
    t.index ["product_type_id"], name: "index_products_on_product_type_id", using: :btree
  end

  create_table "products_vmes", force: :cascade do |t|
    t.float    "vme_id"
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "product_id",                 null: false
    t.index ["product_id"], name: "index_products_vmes_on_product_id", using: :btree
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "description"
    t.date     "from_date"
    t.date     "to_date"
    t.boolean  "status",                              null: false
    t.float    "full_price",                          null: false
    t.float    "promo_price",                         null: false
    t.float    "discount_percentage"
    t.integer  "priority",                            null: false
    t.integer  "max_coupons"
    t.boolean  "deleted",             default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["name", "deleted"], name: "index_promotions_on_name_and_deleted", unique: true, using: :btree
  end

  create_table "promotions_vmes", force: :cascade do |t|
    t.float    "vme_id"
    t.boolean  "deleted",      default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "promotion_id",                 null: false
    t.index ["promotion_id"], name: "index_promotions_vmes_on_promotion_id", using: :btree
  end

  create_table "proveedor_item_mantencion", primary_key: ["id_pauta", "ide_rut", "suc_id", "id_item_mantencion"], force: :cascade do |t|
    t.integer "id_pauta",           null: false
    t.integer "ide_rut",            null: false
    t.integer "suc_id",             null: false
    t.integer "id_item_mantencion", null: false
    t.decimal "valor"
    t.decimal "valor_descuento"
    t.decimal "porcentaje"
  end

  create_table "proveedor_taller", primary_key: "ide_rut", id: :integer, comment: "Rut taller", force: :cascade do |t|
    t.string  "ide_dv",        limit: 1,               null: false
    t.text    "ide_nombre_rz",                         null: false
    t.integer "ide_estado",              default: 1,   null: false
    t.text    "ide_alias",               default: " ", null: false
  end

  create_table "proveedor_taller_sucursal", primary_key: ["ide_rut", "suc_id"], force: :cascade do |t|
    t.integer "ide_rut",                             null: false
    t.integer "suc_id",                              null: false
    t.text    "pts_nombre",                          null: false
    t.integer "pts_estado",              default: 1, null: false
    t.text    "pts_direccion",                       null: false
    t.integer "id_comuna",                           null: false
    t.text    "telefono"
    t.text    "email"
    t.text    "horario_atencion_habil"
    t.text    "horario_atencion_inabil"
    t.text    "waze_url"
    t.text    "agenda_url"
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
    t.index ["v_rvm"], name: "idx_v_rvm", unique: true, using: :btree
    t.index ["v_rvm"], name: "index_v_rvm", using: :btree
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "rut",                        null: false
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name", "deleted"], name: "index_shops_on_name_and_deleted", unique: true, using: :btree
    t.index ["rut", "deleted"], name: "index_shops_on_rut_and_deleted", unique: true, using: :btree
  end

# Could not dump table "solicitud_agendamiento" because of following StandardError
#   Unknown type 'time with time zone' for column 'hora_solicitud_agendamiento'

# Could not dump table "solicitud_cotizaciones" because of following StandardError
#   Unknown type 'time with time zone' for column 'hora_solicitud_cotizacion'

  create_table "solicitud_enc_alternativas", primary_key: ["id_sol_encuesta", "id_alternativas_enc"], force: :cascade do |t|
    t.integer "id_sol_encuesta",                 null: false
    t.integer "id_alternativas_enc",             null: false
    t.integer "aceptada",            default: 0, null: false
  end

# Could not dump table "solicitud_encuesta" because of following StandardError
#   Unknown type 'time with time zone' for column 'hora_encuesta'

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
  add_foreign_key "branches", "shops"
  add_foreign_key "branches_manteinance_items", "branches"
  add_foreign_key "branches_manteinance_items", "item_mantencion", column: "manteinance_item_id", primary_key: "id_item_mantencion"
  add_foreign_key "branches_manteinance_items", "pauta", column: "pauta_id", primary_key: "id_pauta"
  add_foreign_key "branches_products", "branches"
  add_foreign_key "branches_products", "products"
  add_foreign_key "branches_promotions", "branches"
  add_foreign_key "branches_promotions", "promotions"
  add_foreign_key "clients", "comuna", column: "comune_id", primary_key: "id_comuna"
  add_foreign_key "clients", "rvm", primary_key: "v_rvm"
  add_foreign_key "coupons", "clients"
  add_foreign_key "coupons", "promotions"
  add_foreign_key "envios_mail_cliente", "marca", column: "id_marca", primary_key: "id_marca", name: "fk_marca"
  add_foreign_key "envios_mail_cliente", "modelo", column: "id_modelo", primary_key: "id_modelo", name: "fk_modelo"
  add_foreign_key "envios_mail_cliente", "pauta", column: "id_pauta", primary_key: "id_pauta", name: "fk_pauta"
  add_foreign_key "ingresos", "marca", column: "id_marca", primary_key: "id_marca", name: "fk_marca"
  add_foreign_key "ingresos", "modelo", column: "id_modelo", primary_key: "id_modelo", name: "fk_modelo"
  add_foreign_key "ingresos", "pauta", column: "id_pauta", primary_key: "id_pauta", name: "fk_pauta"
  add_foreign_key "item_mantencion", "tipo_seccion", column: "id_tipo_seccion", primary_key: "id_tiposeccion", name: "fk_tiposeccion"
  add_foreign_key "manteinance_coupons", "branches"
  add_foreign_key "manteinance_coupons", "clients"
  add_foreign_key "manteinance_coupons", "pauta", column: "pauta_id", primary_key: "id_pauta"
  add_foreign_key "modelo", "marca", column: "id_marca", primary_key: "id_marca", name: "fk_marca"
  add_foreign_key "pauta", "marca", column: "id_marca", primary_key: "id_marca", name: "fk_id_marca"
  add_foreign_key "pauta", "modelo", column: "id_modelo", primary_key: "id_modelo", name: "fk_id_modelo"
  add_foreign_key "pauta_detalle", "item_mantencion", column: "id_item_mantencion", primary_key: "id_item_mantencion", name: "fk_item_mantencion"
  add_foreign_key "pauta_detalle", "pauta", column: "id_pauta", primary_key: "id_pauta", name: "fk_pauta"
  add_foreign_key "pauta_proveedor", "pauta", column: "id_pauta", primary_key: "id_pauta", name: "fk_pauta"
  add_foreign_key "pauta_proveedor", "proveedor_taller_sucursal", column: "ide_rut", primary_key: "ide_rut", name: "fk_proveedor_sucursal"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "product_brands"
  add_foreign_key "products", "product_types"
  add_foreign_key "products_vmes", "products"
  add_foreign_key "products_vmes", "vehiculo_modelo_especifico", column: "vme_id", primary_key: "vme_id"
  add_foreign_key "promotions_vmes", "promotions"
  add_foreign_key "promotions_vmes", "vehiculo_modelo_especifico", column: "vme_id", primary_key: "vme_id"
  add_foreign_key "proveedor_item_mantencion", "item_mantencion", column: "id_item_mantencion", primary_key: "id_item_mantencion", name: "fk_item_mantencion"
  add_foreign_key "proveedor_item_mantencion", "pauta_proveedor", column: "id_pauta", primary_key: "id_pauta", name: "fk_pauta_prov"
  add_foreign_key "proveedor_taller_sucursal", "comuna", column: "id_comuna", primary_key: "id_comuna", name: "fk_comuna"
  add_foreign_key "proveedor_taller_sucursal", "proveedor_taller", column: "ide_rut", primary_key: "ide_rut", name: "fk_proveedor_taller"
  add_foreign_key "solicitud_agendamiento", "marca", column: "id_marca", primary_key: "id_marca", name: "fk_marca"
  add_foreign_key "solicitud_agendamiento", "modelo", column: "id_modelo", primary_key: "id_modelo", name: "fk_modelo"
  add_foreign_key "solicitud_agendamiento", "pauta", column: "id_pauta", primary_key: "id_pauta", name: "fk_pauta"
  add_foreign_key "solicitud_agendamiento", "proveedor_taller_sucursal", column: "ide_rut", primary_key: "ide_rut", name: "fk_proveedor_taller_sucursal"
  add_foreign_key "solicitud_cotizaciones", "comuna", column: "id_comuna", primary_key: "id_comuna", name: "fk_comuna"
  add_foreign_key "solicitud_cotizaciones", "marca", column: "id_marca", primary_key: "id_marca", name: "fk_marca"
  add_foreign_key "solicitud_cotizaciones", "modelo", column: "id_modelo", primary_key: "id_modelo", name: "fk_modelo"
  add_foreign_key "solicitud_cotizaciones", "pauta", column: "id_pauta", primary_key: "id_pauta", name: "fk_pauta"
  add_foreign_key "solicitud_enc_alternativas", "mm_alternativas_encuesta", column: "id_alternativas_enc", primary_key: "id_alternativas_enc", name: "fk_alternativas"
  add_foreign_key "solicitud_enc_alternativas", "solicitud_encuesta", column: "id_sol_encuesta", primary_key: "id_sol_encuesta", name: "fk_solicitud_encuesta"
  add_foreign_key "solicitud_encuesta", "marca", column: "id_marca", primary_key: "id_marca", name: "fk_marca"
  add_foreign_key "solicitud_encuesta", "modelo", column: "id_modelo", primary_key: "id_modelo", name: "fk_modelo"
  add_foreign_key "vehiculo_modelo_especifico", "modelo", column: "id_modelo", primary_key: "id_modelo", name: "fk_modelo"
  add_foreign_key "vehiculo_modelo_especifico", "tipo_vehiculo", column: "tv_id", primary_key: "tv_id", name: "fk_tipo_vehiculo"
end
