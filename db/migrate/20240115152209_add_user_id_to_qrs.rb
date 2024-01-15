class AddUserIdToQrs < ActiveRecord::Migration[7.0]
  def change
    add_column :qrs, :user_id, :integer
    add_foreign_key :qrs, :users, column: :user_id
    add_index :qrs, :user_id
  end
end
