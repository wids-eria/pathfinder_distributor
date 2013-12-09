class AddControlToUsers < ActiveRecord::Migration
  def up
    add_column :users, :control, :boolean, default: false
  end

  def down
    remove_column :users, :control
  end
end
