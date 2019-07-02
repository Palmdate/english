class AddIpaTrainningToIpaUser < ActiveRecord::Migration[5.2]
  def change
    add_column :ipa_users, :alphabet_trainning, :text
  end
end
