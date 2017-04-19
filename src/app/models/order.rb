class Order < ApplicationRecord
	belongs_to :customer
	has_many :order_items

	def serializable_hash(options=nil)
		if options.present?
			super(options)
		else
			super({
				except: [:customer_id],
				include: {
					customer: { 
						only: [:id, :reference]
					},
					order_items: {
						only: [:id]
					}
				}
			})
		end
	end
end
