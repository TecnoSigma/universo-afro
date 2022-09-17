class CreateCredits < ActiveRecord::Migration[6.1]
  def change
    create_table :credits do |t|
      t.string :url
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
