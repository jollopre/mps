class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :reference, :index => true
      t.string :company_name
      t.string :address
      t.string :telephone
      t.string :email
      t.string :contact_name
      t.string :contact_surname
      t.timestamps
    end
  end
end
