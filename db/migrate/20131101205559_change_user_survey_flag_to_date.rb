class ChangeUserSurveyFlagToDate < ActiveRecord::Migration
   def change
    remove_column :users, :renew_survey

    remove_column :users, :survey
    add_column :users, :survey, :datetime, default: Time.now
  end
end
