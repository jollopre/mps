class Quotation < ApplicationRecord
  include ByDateTime

  belongs_to :customer
  has_many :enquiries

  scope :search, ->(term) {
    by_created_at(term).or(by_updated_at(term))
  }

  def as_json(options=nil)
    return super.merge({ 'enquiry_ids' => enquiry_ids }) unless options.present?
    super(options)
  end
end
