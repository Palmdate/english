class AddUseridToIpaUser < ActiveRecord::Migration[5.2]
  def change
    add_column :ipa_users, :user_id, :integer
  end
end
