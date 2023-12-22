class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :user_type, :integer
  end
end
