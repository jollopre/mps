class Quotation < ApplicationRecord
	include ByDateTime

	belongs_to :customer
	has_many :enquiries

	scope :search, ->(term) {
		by_created_at(term).or(by_updated_at(term))
	}

	def enquiries_to_hash()
		self.enquiries.reduce({}) { |h, oi| h["#{oi.id}"] = oi.as_json(); h }
	end

	def serializable_hash(options=nil)
		if options.present?
			super(options)
		else
			super({}).merge('enquiry_ids' => self.enquiry_ids)
		end
	end
end