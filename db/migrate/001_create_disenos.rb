class CreateDisenos < ActiveRecord::Migration
  def change
    create_table :disenos do |t|
      t.string :nombre_de_orden
      t.string :image
      t.integer :cantidad_del_colores

      t.timestamps
    end
  end
end
