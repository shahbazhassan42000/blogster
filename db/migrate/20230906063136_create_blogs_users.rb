class CreateBlogsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs_users do |t|
      t.references :company, null: false, foreign_key: true
      t.references :blog, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
