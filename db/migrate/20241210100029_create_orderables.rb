class CreateOrderables < ActiveRecord::Migration[7.1]
  def change
    create_table :orderables do |t|
      t.integer :quantity
      t.references :plant, null: false, foreign_key: true
      t.timestamps
    end
  end
end
