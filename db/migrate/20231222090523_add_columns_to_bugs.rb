class AddColumnsToBugs < ActiveRecord::Migration[7.0]
  def change
    add_column :bugs, :title, :string
    add_column :bugs, :description, :text
    add_column :bugs, :bug_type, :integer
    add_column :bugs, :status, :integer
    add_column :bugs, :deadline, :datetime
  end
end
