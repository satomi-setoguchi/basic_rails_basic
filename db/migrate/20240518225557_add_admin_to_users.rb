class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :boolean,  null: false, default: false
  end
end
