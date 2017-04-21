class Order < ApplicationRecord
	belongs_to :customer
	has_many :order_items

	def order_items_to_hash()
		self.order_items.reduce({}) { |h, oi| h["#{oi.id}"] = oi.as_json(); h }
	end

	def serializable_hash(options=nil)
		if options.present?
			super(options)
		else
			super({
				except: [:customer_id],
				include: [:customer]
			}).merge(order_items: order_items_to_hash)
		end
	end
end