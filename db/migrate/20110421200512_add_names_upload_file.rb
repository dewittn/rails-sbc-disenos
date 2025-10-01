class AddNamesUploadFile < ActiveRecord::Migration
  def change
    add_column :disenos, :names_file_name, :string
    add_column :disenos, :names_content_type, :string
    add_column :disenos, :names_file_size, :string
  end
end
