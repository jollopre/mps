class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :product
	has_many :feature_values
	has_many :features, through: :feature_values
end
