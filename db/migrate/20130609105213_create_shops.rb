class CreateShops < ActiveRecord::Migration[4.2]
  def change
    create_table :shops do |t|
      t.string :name

      t.timestamps
    end
  end
end
