class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :state
      t.string :city
      t.string :most_recent_position
      t.string :job_type
      t.string :vacancy_state
      t.string :vacancy_city
      t.boolean :vacancy_alert, default: false
      t.boolean :remote_job, default: false
      t.boolean :never_worked, default: false
      t.string :afro_id
      t.integer :status, default: Statuses::CANDIDATE[:pendent]

      t.timestamps
    end
  end
end
