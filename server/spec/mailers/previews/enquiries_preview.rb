# Preview all emails at http://localhost:3000/rails/mailers/enquiries
class EnquiriesPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/enquiries/as_attachment
  def as_attachment
    enquiries = [Enquiry.new(quantity: 5), Enquiry.new(quantity: 6)]
    suppliers = [Supplier.new(email: 'supplier1@foo.bar'), Supplier.new(email: 'supplier2@foo.bar')]
    composed_email = ComposedEmail.new(
      subject: 'A subject',
      body: 'A body',
      enquiries: enquiries,
      suppliers: suppliers,
      enquiries: enquiries
    ) 
    EnquiriesMailer.as_attachment(composed_email)
  end

end
