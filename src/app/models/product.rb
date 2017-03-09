class Product < ApplicationRecord
	has_and_belongs_to_many :features
	has_and_belongs_to_many :feature_options
end
