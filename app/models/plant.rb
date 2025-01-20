class Plant < ApplicationRecord
  has_many :orderables
  has_many :carts, through: :orderables

  include PgSearch::Model
  pg_search_scope :search_by,
  against: [:name],
  using: {
    tsearch: { prefix: true }
  }

end
