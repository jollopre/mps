class FeatureLabel < ApplicationRecord
	has_many :features

	def serializable_hash(options = nil)
		if options.present?
			super(options)
		else
			super({only: [:name]})
		end
	end
end
