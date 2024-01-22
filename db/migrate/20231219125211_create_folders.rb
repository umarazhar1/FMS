# frozen_string_literal: true

class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders, &:timestamps
  end
end
