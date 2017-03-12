class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :product
	has_many :order_item_features
	has_many :features, through: :order_item_features
end
