class CreateLostRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :lost_requests do |t|
      t.string :item_type
      t.string :color
      t.string :brand
      t.date :date
      t.string :status
      t.string :user_id
      t.integer :found_code
      t.timestamps
    end
  end
end
