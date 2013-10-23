class AddSuveryToUsers < ActiveRecord::Migration
  def up
    add_column :users, :survey, :boolean, default: false
    add_column :users, :renew_survey, :boolean, default: false
  end

  def down
    remove_column :users, :renew_survey
    remove_column :users, :survey
  end
end
