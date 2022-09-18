class CreateProfessions < ActiveRecord::Migration[6.1]
  def change
    create_table :professions do |t|
      t.string :name

      t.references :candidate, index: true
    end
  end
end
