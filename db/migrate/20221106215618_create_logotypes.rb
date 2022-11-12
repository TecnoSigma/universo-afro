# frozen_string_literal: true

class CreateLogotypes < ActiveRecord::Migration[6.1]
  def change
    create_table :logotypes do |t|
      t.binary :data
      t.string :filename
      t.string :mime_type

      t.references :company, index: true

      t.timestamps
    end
  end
end
