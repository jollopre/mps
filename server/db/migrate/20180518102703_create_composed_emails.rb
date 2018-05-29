class CreateComposedEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :composed_emails do |t|
    	t.string :subject
    	t.text :body
    	t.binary :attachment	# Used to store a pdf that holds several enquiries
    	t.timestamp :delivered_at
      t.timestamps
    end

    create_table :composed_emails_enquiries, id: false do |t|
    	t.belongs_to :composed_email, index: true
    	t.belongs_to :enquiry, index: true
    end

    create_table :composed_emails_suppliers, id: false do |t|
    	t.belongs_to :composed_email, index: true
    	t.belongs_to :supplier, index: true
    end
  end
end
