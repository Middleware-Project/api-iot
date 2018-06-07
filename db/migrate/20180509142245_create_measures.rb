class CreateMeasures < ActiveRecord::Migration[5.2]
  def change
    create_table :measures do |t|
      t.float :data
      t.string :unit
      t.belongs_to :node, index: true
      t.belongs_to :sensor, index: true

      t.timestamps
    end
  end
end
