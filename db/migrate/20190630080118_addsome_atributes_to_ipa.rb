class AddsomeAtributesToIpa < ActiveRecord::Migration[5.2]
  def change
    add_column :ipas, :gif, :string
    add_column :ipas, :description, :text
  end
end
