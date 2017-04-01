class Order < ApplicationRecord
	belongs_to :customer
	has_many :order_items

	def as_json(options=nil)
		if options.nil?
			super({
				only: :id,
				include: {
					customer: { 
						only: [:reference, :telephone, :email, :contact_name, :contact_surname]
					},
					order_items: {
						only: [:id]
					}
				}
			})
		else
			super(options)
		end
	end
end
