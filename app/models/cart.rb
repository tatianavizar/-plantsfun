class Cart < ApplicationRecord
  has_many :orderables
  has_many :plants, through: :orderables
  has_one :order

  def subtotal
    orderables.to_a.sum {|orderable| orderable.total_plant}
  end

  def shipping
    10
  end

  def total
    value_1 = subtotal
    value_2 = shipping
    return value_1 + value_2
  end
end
