class AddResultAttributeAtReadAloudChart < ActiveRecord::Migration[5.2]
  def change
    add_column :read_aloud_charts, :result, :text
  end
end
