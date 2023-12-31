# frozen_string_literal: true

class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.references :state, index: true
    end
  end
end
