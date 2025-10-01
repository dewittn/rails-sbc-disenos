class PaperClipFiles < ActiveRecord::Migration
  def up
    add_column :disenos, :archivo_dst_file_name, :string
    add_column :disenos, :archivo_dst_content_type, :string
    add_column :disenos, :archivo_dst_file_size, :string
    remove_column :disenos, :archivo_dst
    add_column :disenos, :archivo_pes_file_name, :string
    add_column :disenos, :archivo_pes_content_type, :string
    add_column :disenos, :archivo_pes_file_size, :string
    remove_column :disenos, :archivo_pes
    rename_column :disenos, :image__file_size, :image_file_size
  end

  def down
    rename_column :disenos, :image_file_size, :image__file_size
    add_column :disenos, :archivo_pes, :string
    remove_column :disenos, :archivo_pes_file_size
    remove_column :disenos, :archivo_pes_content_type
    remove_column :disenos, :archivo_pes_file_name
    add_column :disenos, :archivo_dst, :string
    remove_column :disenos, :archivo_dst_file_size
    remove_column :disenos, :archivo_dst_content_type
    remove_column :disenos, :archivo_dst_file_name
  end
end
