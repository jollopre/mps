class FeatureOption < ApplicationRecord
	belongs_to :feature
	has_and_belongs_to_many :products
end
