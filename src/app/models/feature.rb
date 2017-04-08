class Feature < ApplicationRecord
	# Relations
	belongs_to :product
	belongs_to :feature_label
	has_many :feature_options
	has_many :feature_values

	# Enum attributes. If new value is added, it should be added at the end of the array
	# in order to preserve mapping to database integers (e.g. float: 0, integer: 1 and so on)
	enum feature_type: [:float, :integer, :option, :string]

	# Validations
	validates :feature_type, 
		inclusion: { in: self.feature_types.keys() ,
					 message: '%{value} is not a valid feature_type.' }

	# Scope to be applied across all queries to the model
	default_scope { includes(:feature_label, :feature_options)} #TODO This might affect performance (e.g. when checking value in FeatureValue accoding to feature.feature_type)

	def serializable_hash(options = nil)
		if options.present?
			super(options)
		else
			super({only:[:id, :feature_type],
				include: [:feature_label, :feature_options]})
		end
	end
end
