class CreateReadAloudCharts < ActiveRecord::Migration[5.2]
  def change
    create_table :read_aloud_charts do |t|
      t.integer :sentence
      t.integer :rate
      t.integer :total
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end
end
