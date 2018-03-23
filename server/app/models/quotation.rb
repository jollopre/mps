class Quotation < ApplicationRecord
	include ByDateTime

	belongs_to :customer
	has_many :order_items

	scope :search, ->(term) {
		by_created_at(term).or(by_updated_at(term))
	}

	def order_items_to_hash()
		self.order_items.reduce({}) { |h, oi| h["#{oi.id}"] = oi.as_json(); h }
	end

	def serializable_hash(options=nil)
		if options.present?
			super(options)
		else
			super({}).merge('order_item_ids' => self.order_item_ids)
		end
	end
end