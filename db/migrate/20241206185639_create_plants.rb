class CreatePlants < ActiveRecord::Migration[7.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :category
      t.string :level
      t.integer :inventory
      t.timestamps
    end
  end
end
