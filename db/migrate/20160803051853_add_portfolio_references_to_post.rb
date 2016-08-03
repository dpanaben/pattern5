class AddPortfolioReferencesToPost < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :portfolio, foreign_key: true
  end
end
