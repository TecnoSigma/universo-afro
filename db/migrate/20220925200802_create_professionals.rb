class CreateProfessionals < ActiveRecord::Migration[6.1]
  def change
    create_table :professionals do |t|
      t.string :first_name
      t.string :last_name
      t.string :cpf
      t.string :email
      t.string :password
      t.string :address
      t.string :number
      t.string :complement
      t.string :district
      t.string :city
      t.string :state
      t.string :postal_code
      t.integer :status, default: Statuses::PROFESSIONAL[:pendent]

      t.references :profession, index: true

      t.timestamps
    end
  end
end
