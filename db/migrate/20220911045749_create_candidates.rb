class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :afro_id
      t.integer :status, default: Statuses::CANDIDATE[:pendent]

      t.timestamps
    end
  end
end
