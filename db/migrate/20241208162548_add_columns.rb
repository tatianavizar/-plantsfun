class AddColumns < ActiveRecord::Migration[7.1]
  def change
    add_column :plants, :image, :string
    add_column :plants, :price, :float
  end
end
