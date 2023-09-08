class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.references :company, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :title
      t.text :content
      t.integer :status, default: 0
      t.string :featured_image, default: 'default_picture.png'
      t.text :excerpt

      t.timestamps
    end
  end
end
