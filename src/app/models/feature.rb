class Feature < ApplicationRecord
	has_many :feature_options
	has_and_belongs_to_many :products
	has_many :order_item_features
	# type must be {number, text or options }
end
