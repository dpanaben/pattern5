class AddUserIdToPortfolio < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :user_id, :integer
  end
end
