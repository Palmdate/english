class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.text :skill
      t.text :quality
      t.text :status

      t.timestamps
    end
  end
end
