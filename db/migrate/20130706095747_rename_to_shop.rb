class RenameToShop < ActiveRecord::Migration[4.2]
  def change
    rename_column :shops, :name, :title
  end
end
