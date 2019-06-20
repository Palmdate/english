class CreateIpas < ActiveRecord::Migration[5.2]
  def change
    create_table :ipas do |t|
      t.string :name
      t.text :list_words

      t.timestamps
    end
  end
end
