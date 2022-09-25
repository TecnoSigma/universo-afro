class CreateVacantJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :vacant_jobs do |t|
      t.string :type
      t.string :category
      t.string :state
      t.string :city
      t.boolean :alert
      t.boolean :remote

      t.references :profession, index: true
      t.references :candidate, index: true

      t.timestamps
    end
  end
end
