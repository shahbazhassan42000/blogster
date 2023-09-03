class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :slug
      t.string :logo
      t.string :poster
      t.text :about
      t.integer :active, default: 0
      t.references :owner, references: :users, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
