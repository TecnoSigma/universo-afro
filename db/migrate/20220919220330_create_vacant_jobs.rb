# frozen_string_literal: true

class CreateVacantJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :vacant_jobs do |t|
      t.string :type
      t.string :category
      t.string :state
      t.string :city
      t.boolean :alert, default: false
      t.boolean :remote, default: false
      t.integer :status, default: Statuses::VACANT_JOB[:opened]

      # Company Vacant Job
      t.string :vacant_job_id
      t.text :details
      t.integer :availabled_quantity, default: 0
      t.integer :filled_quantity, default: 0

      t.references :profession, index: true
      t.references :candidate, index: true
      t.references :company, index: true

      t.timestamps
    end
  end
end
