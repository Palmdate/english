class CreateReadAlouds < ActiveRecord::Migration[5.2]
  def change
    create_table :read_alouds do |t|

      t.timestamps
    end
  end
end
