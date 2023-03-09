class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :reference
      t.float :price
      t.string :code
      t.integer :status

      t.timestamps
    end
  end
end
