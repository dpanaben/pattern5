class AddPortfolioIdToSanitize < ActiveRecord::Migration[5.0]
  def change
    add_column :sanitizes, :portfolio_id, :integer
  end
end
