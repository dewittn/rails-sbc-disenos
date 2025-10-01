class CreateHilos < ActiveRecord::Migration
  def change
    create_table :hilos do |t|
      t.integer :diseno_id
      t.references :color

      t.timestamps
    end
  end
end
