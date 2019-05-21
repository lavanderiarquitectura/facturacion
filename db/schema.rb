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

ActiveRecord::Schema.define(version: 2019_05_19_201230) do

  create_table "fac_factura_locals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "id_cuarto", null: false
    t.integer "cobro_local", default: 0, null: false
    t.date "fecha", null: false
    t.integer "estado_local", limit: 1, default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "fac_globals_id"
    t.index ["fac_globals_id"], name: "index_fac_factura_locals_on_fac_globals_id"
  end

  create_table "fac_globals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "id_cuarto", null: false
    t.integer "cobro_global", null: false
    t.date "fecha", null: false
    t.integer "estado_global", limit: 1, default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fac_prendas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "id_prenda", null: false
    t.string "id_cuarto", null: false
    t.integer "cobro", null: false
    t.date "fecha", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "fac_factura_locals_id"
    t.integer "estado_prenda", limit: 1
    t.index ["fac_factura_locals_id"], name: "index_fac_prendas_on_fac_factura_locals_id"
  end

  create_table "fac_recargo_operacions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "recargo", null: false
    t.integer "id_operacion", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fac_recargo_telas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "recargo", null: false
    t.integer "id_tipo_tela", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "fac_factura_locals", "fac_globals", column: "fac_globals_id"
  add_foreign_key "fac_prendas", "fac_factura_locals", column: "fac_factura_locals_id"
end
