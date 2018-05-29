class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
    	t.string :reference, :index => true
    	t.string :company_name
    	t.string :contact
    	t.string :email
    	t.string :telephone
      t.timestamps
    end
  end
end
