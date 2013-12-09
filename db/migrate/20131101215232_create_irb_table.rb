class CreateIrbTable < ActiveRecord::Migration
  def change
    create_table :irbs do |t|
      t.string :version
      t.timestamps
    end
  end
end
