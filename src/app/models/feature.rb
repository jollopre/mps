class Feature < ApplicationRecord
	# Create validation rule for feature_type must be {number, text or options }
	belongs_to :product
	belongs_to :feature_label
	has_many :feature_options
	has_many :order_item_features
end
