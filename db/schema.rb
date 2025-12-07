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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20110421200512) do

  create_table "colors", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.string   "codigo",     limit: 255
    t.integer  "marca_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hex",        limit: 255
  end

  create_table "disenos", force: :cascade do |t|
    t.string   "nombre_de_orden",          limit: 255
    t.integer  "cantidad_del_colores",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",          limit: 255
    t.string   "image_content_type",       limit: 255
    t.string   "image_file_size",          limit: 255
    t.string   "archivo_dst_file_name",    limit: 255
    t.string   "archivo_dst_content_type", limit: 255
    t.string   "archivo_dst_file_size",    limit: 255
    t.string   "archivo_pes_file_name",    limit: 255
    t.string   "archivo_pes_content_type", limit: 255
    t.string   "archivo_pes_file_size",    limit: 255
    t.boolean  "delta"
    t.text     "notas",                    limit: 65535
    t.string   "original_file_name",       limit: 255
    t.string   "original_content_type",    limit: 255
    t.integer  "original_file_size",       limit: 4
    t.datetime "original_updated_at"
    t.string   "names_file_name",          limit: 255
    t.string   "names_content_type",       limit: 255
    t.string   "names_file_size",          limit: 255
  end

  create_table "hilos", force: :cascade do |t|
    t.integer  "diseno_id",  limit: 4
    t.integer  "color_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marcas", force: :cascade do |t|
    t.string   "nombre",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timeline_events", force: :cascade do |t|
    t.string   "event_type",             limit: 255
    t.string   "subject_type",           limit: 255
    t.string   "actor_type",             limit: 255
    t.string   "secondary_subject_type", limit: 255
    t.integer  "subject_id",             limit: 4
    t.integer  "actor_id",               limit: 4
    t.integer  "secondary_subject_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
