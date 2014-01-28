class AddAdaidToUser < ActiveRecord::Migration
  def up
    add_column :users, :ada_id, :integer
  end

  def down
    remove_column :users, :ada_id
  end
end
