class ComposedEmail < ApplicationRecord
  has_and_belongs_to_many :enquiries
  has_and_belongs_to_many :suppliers

  # Validations
  validates_presence_of :subject, :body, :enquiries, :suppliers

  def send_email!
    raise 'Email has been already delivered' unless delivered_at.nil?
    EnquiriesMailer.as_attachment(self).deliver_now
  end
  def serializable_hash(options = nil)
    if options.present?
      super(options)
    else
      super(except: [:created_at, :updated_at]).merge({ 'enquiry_ids' => self.enquiry_ids, 'supplier_ids' => self.supplier_ids })
    end
  end
end
