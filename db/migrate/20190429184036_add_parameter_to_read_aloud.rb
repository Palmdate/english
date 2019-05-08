class AddParameterToReadAloud < ActiveRecord::Migration[5.2]
  def change
    add_column :read_alouds, :user_id, :integer
    add_column :read_alouds, :audio_user, :string
    add_column :read_alouds, :content, :string
  end
end
