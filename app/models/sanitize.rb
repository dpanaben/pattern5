class Sanitize < ApplicationRecord
  enum status: [:off, :on]
  belongs_to :cop, class_name: "User", foreign_key: :user_id

end
