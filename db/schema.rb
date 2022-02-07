# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 5) do

  create_table "colors", :force => true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.integer  "marca_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disenos", :force => true do |t|
    t.string   "nombre_de_orden"
    t.string   "image"
    t.integer  "cantidad_del_colores"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "archivo_dst"
    t.string   "archivo_pes"
  end

  create_table "hilos", :force => true do |t|
    t.integer  "diseno_id"
    t.integer  "color_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marcas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
