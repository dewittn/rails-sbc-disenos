class AddDeltaToDiseno < ActiveRecord::Migration
  def change
    add_column :disenos, :delta, :boolean
  end
end
