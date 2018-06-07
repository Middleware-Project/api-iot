class CreateSensors < ActiveRecord::Migration[5.2]
  def change
    create_table :sensors do |t|
      t.string :name
      t.text :description
      t.string :units

      t.timestamps
    end
  end
end
