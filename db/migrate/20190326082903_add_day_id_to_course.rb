class AddDayIdToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :day_id, :integer
  end
end
