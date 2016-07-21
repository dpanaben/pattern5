class AddUserReferencesToSanitize < ActiveRecord::Migration[5.0]
  def change
    add_reference :sanitizes, :user, foreign_key: true
  end
end
