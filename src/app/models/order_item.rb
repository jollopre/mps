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

	def feature_values_to_hash()
		self.feature_values.reduce({}) { |h, fv| h["#{fv.id}"] = fv.as_json(); h }
	end

	def serializable_hash(options = nil)
		if options.present?
			super(options)
		else
			super({
					only: [:id, :quantity],
					include: [:product]
				}).merge(feature_values: feature_values_to_hash)
		end
	end

	protected
		def create_feature_values
			features = self.product.features
			features.each do |f|
				self.feature_values << FeatureValue.new({order_item_id: self.id, feature_id: f.id, value: '' })
			end
			self.save
		end
end
