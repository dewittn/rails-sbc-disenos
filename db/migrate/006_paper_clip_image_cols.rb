class PaperClipImageCols < ActiveRecord::Migration
  def up
    add_column :disenos, :image_file_name, :string
    add_column :disenos, :image_content_type, :string
    add_column :disenos, :image__file_size, :string
    remove_column :disenos, :image
  end

  def down
    add_column :disenos, :image, :string
    remove_column :disenos, :image__file_size
    remove_column :disenos, :image_content_type
    remove_column :disenos, :image_file_name
  end
end
