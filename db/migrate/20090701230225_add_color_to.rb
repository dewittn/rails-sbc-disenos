class AddColorTo < ActiveRecord::Migration
  def change
    add_column :colors, :hex, :string
  end
end
