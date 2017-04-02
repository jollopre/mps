class FeatureValue < ApplicationRecord
	belongs_to :order_item
	belongs_to :feature
end
