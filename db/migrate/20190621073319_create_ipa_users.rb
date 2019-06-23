class CreateIpaUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :ipa_users do |t|
      t.text :alphabet_wrong
      t.text :alphabet_done

      t.timestamps
    end
  end
end
