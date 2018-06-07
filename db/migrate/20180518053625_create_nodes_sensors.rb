class CreateNodesSensors < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes_sensors, id:false do |t|
      t.belongs_to :node, index: true
      t.belongs_to :sensor, index: true
    end
  end
end
