class AddNamesUploadFile < ActiveRecord::Migration
  def self.up
    add_column :disenos, :names_file_name, :string
    add_column :disenos, :names_content_type, :string
    add_column :disenos, :names_file_size, :string
  end

  def self.down
    remove_column :disenos, :names_file_size
    remove_column :disenos, :names_content_type
    remove_column :disenos, :names_file_name
  end
end
