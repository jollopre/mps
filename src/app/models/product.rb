class Product < ApplicationRecord
	has_many :features

	# Scope to be applied across all queries to the model
	default_scope { includes(:features) }
end
