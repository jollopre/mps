class Feature < ApplicationRecord
	belongs_to :product
	has_many :feature_options
	has_many :order_item_features
	# feature_type must be {number, text or options }
end
