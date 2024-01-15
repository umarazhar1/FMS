class AddUserIdToFolders < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :user_id, :integer
    add_foreign_key :folders, :users, column: :user_id
    add_index :folders, :user_id
  end
end
