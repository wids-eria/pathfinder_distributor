class AddRenewIrbToUsers < ActiveRecord::Migration
  def up
    add_column :users, :renew_consent, :boolean, default: false
  end

  def down
    remove_column :users, :renew_consent
  end
end
