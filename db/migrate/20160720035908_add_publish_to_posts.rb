class AddPublishToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :publish, :integer, default: 0
  end
end
