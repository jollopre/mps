class ComposedEmail < ApplicationRecord
  has_and_belongs_to_many :enquiries
  has_and_belongs_to_many :suppliers

  validates :subject, :body, :enquiries, :suppliers, presence: true

  def send_email!
    raise EmailAlreadyDelivered.new('Email has been already delivered') unless delivered_at.nil?
    EnquiriesMailer.as_attachment(self).deliver_now
    update_column(:delivered_at, Time.now)
  end

  def as_json(options = nil)
    return super(except: [:created_at, :updated_at]).merge({ 'enquiry_ids' => self.enquiry_ids, 'supplier_ids' => self.supplier_ids }) unless options.present?
    super(options)
  end

  class EmailAlreadyDelivered < StandardError ; end
end
