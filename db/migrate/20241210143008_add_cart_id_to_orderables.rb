class AddCartIdToOrderables < ActiveRecord::Migration[7.1]
  def change
    add_column :orderables, :cart_id, :integer
  end
end
