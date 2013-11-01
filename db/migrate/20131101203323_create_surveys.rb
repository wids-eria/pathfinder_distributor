class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.version :string

      t.timestamps
    end
  end
end
