class CreateCandidatures < ActiveRecord::Migration[6.1]
  def change
    create_table :candidatures do |t|
      t.references :company_vacant_job, index: true
      t.references :candidate_vacant_job, index: true
    end
  end
end
