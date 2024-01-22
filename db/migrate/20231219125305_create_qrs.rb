# frozen_string_literal: true

class CreateQrs < ActiveRecord::Migration[7.0]
  def change
    create_table :qrs do |t|
      t.references :folder, null: true, foreign_key: true

      t.timestamps
    end
  end
end
