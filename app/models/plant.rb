class Plant < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search_by,
  against: [:name],
  using: {
    tsearch: { prefix: true }
  }

end
