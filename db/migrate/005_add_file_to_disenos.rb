class AddFileToDisenos < ActiveRecord::Migration
  def change
    add_column :disenos, :archivo_dst, :string
    add_column :disenos, :archivo_pes, :string
  end
end
