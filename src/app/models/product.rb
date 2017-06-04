class Product < ApplicationRecord
	has_many :features

	# Scope to be applied across all queries to the model
	default_scope { includes(features: [
		:feature_label, :feature_options])
	}

	def features_to_hash()
		self.features.reduce({}){ |h,f| h["#{f.id}"] = f.as_json(); h }
	end

	def serializable_hash(options=nil)
		if options.present?
			super(options)
		else
			super({ only: [:id, :name] }).merge('features' => features_to_hash)
		end
	end
end
