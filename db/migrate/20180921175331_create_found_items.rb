class CreateFoundItems < ActiveRecord::Migration[5.2]
  def change
    create_table :found_items do |t|
      t.string :item_type
      t.string :color
      t.string :brand
      t.string :status
      t.string :storage_loc
      t.string :locker_id

      t.timestamps
    end
  end
end
