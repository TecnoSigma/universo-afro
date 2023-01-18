class CreateConferences < ActiveRecord::Migration[6.1]
  def change
    create_table :conferences do |t|
      t.integer :horary
      t.integer :date
      t.string :afro_id
      t.integer :status, default: Statuses::CONFERENCE[:pendent]

      t.references :candidate, index: true
      t.references :company, index: true
    end
  end
end
