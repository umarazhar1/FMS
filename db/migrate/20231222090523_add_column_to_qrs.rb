# frozen_string_literal: true

class AddColumnToQrs < ActiveRecord::Migration[7.0]
  def change
    add_column :qrs, :name, :string
  end
end
