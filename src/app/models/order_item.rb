class OrderItem < ApplicationRecord
	# Associations
	belongs_to :order
	belongs_to :product
	has_many :feature_values
	has_many :features, through: :feature_values

	# Validations
	validates :quantity, numericality: { only_integer: true }
	
	# Callbacks
	after_create :create_feature_values

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

	protected
		def create_feature_values
			features = self.product.features #TODO, eager loading of features
			features.each do |f|
				self.feature_values << FeatureValue.new({order_item_id: self.id, feature_id: f.id, value: '' })
			end
			self.save
		end
end
