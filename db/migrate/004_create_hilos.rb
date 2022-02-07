class CreateHilos < ActiveRecord::Migration
  def self.up
    create_table :hilos do |t|
      t.integer :diseno_id      
      t.references :color
      
      t.timestamps
    end
  end

  def self.down
    drop_table :hilos
  end
end
