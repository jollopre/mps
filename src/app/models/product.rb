class Product < ApplicationRecord
	has_many :features

	# Scope to be applied across all queries to the model
	default_scope { includes(features: [
		:feature_label, :feature_options])
	}

	def serializable_hash(options=nil)
		if options.present?
			super(options)
		else
			super({ only: [:id, :name],
					include: :features})
		end
	end
end
