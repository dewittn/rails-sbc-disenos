class AddDeltaToDiseno < ActiveRecord::Migration
  def self.up
    add_column :disenos, :delta, :boolean
  end

  def self.down
    remove_column :disenos, :delta
  end
end
