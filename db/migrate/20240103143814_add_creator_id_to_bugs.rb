class AddCreatorIdToBugs < ActiveRecord::Migration[7.0]
  def change
    add_column :bugs, :creator_id, :integer
    add_foreign_key :bugs, :users, column: :creator_id
    add_index :bugs, :creator_id
  end
end
