# frozen_string_literal: true

class CreateStates < ActiveRecord::Migration[6.1]
  def change
    create_table :states do |t|
      t.string :name
      t.string :uf
      t.integer :external_id
    end
  end
end
