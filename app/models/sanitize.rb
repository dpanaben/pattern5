class Sanitize < ApplicationRecord
  enum status: [:off, :on]
  belongs_to :portfolio

end
