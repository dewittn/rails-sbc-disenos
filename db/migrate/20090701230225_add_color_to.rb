class AddColorTo < ActiveRecord::Migration
  def self.up
    add_column :colors, :hex, :string
  end

  def self.down
    remove_column :hilos, :hex
  end
end
