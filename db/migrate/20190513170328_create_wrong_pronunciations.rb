class CreateWrongPronunciations < ActiveRecord::Migration[5.2]
  def change
    create_table :wrong_pronunciations do |t|
      t.integer :user_id
      t.string :wrong_words
      t.string :wrong_phonetic

      t.timestamps
    end
  end
end
