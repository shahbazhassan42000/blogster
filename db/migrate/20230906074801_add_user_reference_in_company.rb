class AddUserReferenceInCompany < ActiveRecord::Migration[6.1]
  def change
    add_reference :companies, :owner, null: true, foreign_key: { to_table: :users }
  end
end
