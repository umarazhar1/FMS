class AddNameColumnToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :name, :string
    add_column :projects, :description, :text
  end
end
