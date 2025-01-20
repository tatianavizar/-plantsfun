class Orderable < ApplicationRecord
  belongs_to :cart
  belongs_to :plant

  def total_plant
    plant.price * quantity
  end
end
