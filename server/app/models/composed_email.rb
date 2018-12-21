class ComposedEmail < ApplicationRecord
  has_and_belongs_to_many :enquiries
  has_and_belongs_to_many :suppliers

  validates :subject, :body, :enquiries, :suppliers, presence: true

  def send_email!
    raise 'Email has been already delivered' unless delivered_at.nil?
    EnquiriesMailer.as_attachment(self).deliver_now
  end

  def as_json(options = nil)
    return super(except: [:created_at, :updated_at]).merge({ 'enquiry_ids' => self.enquiry_ids, 'supplier_ids' => self.supplier_ids }) unless options.present?
    super(options)
  end
end
