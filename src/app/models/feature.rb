class Feature < ApplicationRecord
	# Relations
	belongs_to :product
	belongs_to :feature_label
	has_many :feature_options
	has_many :order_item_features

	# Enum attributes
	enum feature_type: [:number, :options, :text]

	# Validations
	validates :feature_type, 
		inclusion: { in: self.feature_types.keys() ,
					 message: '%{value} is not a valid feature_type.' }

	# Scope to be applied across all queries to the model
	default_scope { includes(:feature_label, :feature_options)}
end
