class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :surname
    	t.string :email, null: false
    	t.string :password, null: false
    	t.string :token
    	t.datetime :token_created_at
    	t.timestamps
    	t.index :token
    	t.index :email
    end
  end
end
