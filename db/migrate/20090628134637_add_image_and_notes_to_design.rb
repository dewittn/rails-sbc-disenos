class AddImageAndNotesToDesign < ActiveRecord::Migration
  def self.up
    add_column :disenos, :notas, :text
    add_column :disenos, :original_file_name, :string
    add_column :disenos, :original_content_type, :string
    add_column :disenos, :original_file_size, :integer
    add_column :disenos, :original_updated_at, :datetime
  end

  def self.down
    remove_column :disenos, :original_updated_at
    remove_column :disenos, :original_file_size
    remove_column :disenos, :original_content_type
    remove_column :disenos, :original_file_name
    remove_column :disenos, :notas
  end
end
