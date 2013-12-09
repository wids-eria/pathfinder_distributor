class ChangeUserConsentFlag < ActiveRecord::Migration
   def change
    remove_column :users, :renew_consent

    remove_column :users, :consented
    add_column :users, :consented, :datetime, default: Time.now
  end
end