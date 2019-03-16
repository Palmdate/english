class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.text :skill
      t.integer :quality
      t.text :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end

  # add_index :courses, [:user_id, :created_at]

end
