# frozen_string_literal: true

class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :state
      t.string :city
      t.boolean :ethnicity_self_declaration, default: false
      t.string :afro_id
      t.integer :status, default: Statuses::CANDIDATE[:pendent]

      t.timestamps
    end
  end
end
