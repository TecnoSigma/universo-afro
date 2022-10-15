# frozen_string_literal: true

class CreateAvatars < ActiveRecord::Migration[6.1]
  def change
    create_table :avatars do |t|
      t.string :name
      t.binary :data
      t.string :filename
      t.string :mime_type

      t.references :candidate, index: true

      t.timestamps
    end
  end
end
