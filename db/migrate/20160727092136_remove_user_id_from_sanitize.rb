class RemoveUserIdFromSanitize < ActiveRecord::Migration[5.0]
  def change
    remove_reference :sanitizes, :user, foreign_key: true
  end
end
