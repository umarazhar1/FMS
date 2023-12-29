class AddCreatorIdToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :creator_id, :integer
    add_foreign_key :projects, :users, column: :creator_id
    add_index :projects, :creator_id
  end
end
