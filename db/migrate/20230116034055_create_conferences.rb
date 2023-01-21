class CreateConferences < ActiveRecord::Migration[6.1]
  def change
    create_table :conferences do |t|
      t.datetime :date_time
      t.string :afro_id
      t.string :reason
      t.text :description
      t.integer :status, default: Statuses::CONFERENCE[:pendent]

      t.references :candidate, index: true
      t.references :company, index: true
    end
  end
end
