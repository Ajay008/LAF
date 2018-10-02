class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins, id:false do |t|
      t.string :user_id, :primary_key => true
      t.string :password, :null => false
      t.string :name, :null => false
      t.string :location, :null => false
      t.timestamps
    end
  end
end
