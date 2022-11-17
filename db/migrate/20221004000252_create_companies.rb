class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :address
      t.string :city
      t.string :complement
      t.string :cnpj
      t.string :district
      t.string :email
      t.string :nickname
      t.string :name
      t.string :number
      t.string :password
      t.string :postal_code
      t.string :state
      t.integer :status
      t.string :afro_id

      t.timestamps
    end
  end
end
