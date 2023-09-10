class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :slug
      t.text :about
      t.integer :active, default: 0

      t.timestamps
    end
  end
end
