class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :modelName
      t.string :manufacterName
      t.string :description
      t.boolean :status, default: false

      t.belongs_to :group, index: true, foreign_key: true
      t.timestamps
    end
  end
end
