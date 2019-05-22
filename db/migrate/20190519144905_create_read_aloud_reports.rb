class CreateReadAloudReports < ActiveRecord::Migration[5.2]
  def change
    create_table :read_aloud_reports do |t|
      t.integer :user_id
      t.integer :sentence
      t.integer :percent
      t.string :result

      t.timestamps
    end
  end
end
