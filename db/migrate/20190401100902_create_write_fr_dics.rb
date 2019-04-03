class CreateWriteFrDics < ActiveRecord::Migration[5.2]
  def change
    create_table :write_fr_dics do |t|
      t.string :audio
      t.text :content
      t.text :result
      
      t.timestamps
    end
  end
end
