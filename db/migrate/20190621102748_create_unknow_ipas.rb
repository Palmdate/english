class CreateUnknowIpas < ActiveRecord::Migration[5.2]
  def change
    create_table :unknow_ipas do |t|
      t.string :word

      t.timestamps
    end
  end
end
