class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :product
	has_many :feature_values
	has_many :features, through: :feature_values

	def as_json(options = nil)
		if options.nil?
			super({
					only: [:id, :quantity],
					include: {
						product: { only: [:id, :name]},
						feature_values: { 
							only: [:id, :value, :feature_id],
						}
					}
				})
		else
			super(options)
		end
	end
end
