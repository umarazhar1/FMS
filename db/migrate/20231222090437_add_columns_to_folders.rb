# frozen_string_literal: true

class AddColumnsToFolders < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :name, :string
    add_column :folders, :description, :text
  end
end
