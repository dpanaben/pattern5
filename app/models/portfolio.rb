class Portfolio < ApplicationRecord
  has_many :sanitizes, dependent: :nullify

end
