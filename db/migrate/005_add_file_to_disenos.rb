class AddFileToDisenos < ActiveRecord::Migration
  def self.up
    add_column :disenos, :archivo_dst, :string
    add_column :disenos, :archivo_pes, :string
  end

  def self.down
    remove_column :disenos, :archivo_pes
    remove_column :disenos, :archivo_dst
  end
end
