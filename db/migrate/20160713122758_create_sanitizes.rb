class CreateSanitizes < ActiveRecord::Migration[5.0]
  def change
    create_table :sanitizes do |t|
      t.string :match
      t.string :result
      t.text :description
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
