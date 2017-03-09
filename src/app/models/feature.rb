class Feature < ApplicationRecord
	# Create scope rule for feature_type must be {number, text or options }
	has_and_belongs_to_many :products
	has_many :feature_options
	has_many :order_item_features
end
