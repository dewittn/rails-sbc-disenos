class AddImageAndNotesToDesign < ActiveRecord::Migration
  def change
    add_column :disenos, :notas, :text
    add_column :disenos, :original_file_name, :string
    add_column :disenos, :original_content_type, :string
    add_column :disenos, :original_file_size, :integer
    add_column :disenos, :original_updated_at, :datetime
  end
end
