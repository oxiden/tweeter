class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :shop_id
      t.date :release
      t.string :title
      t.text :memo

      t.timestamps
    end
  end
end
