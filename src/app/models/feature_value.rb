class FeatureValue < ApplicationRecord
	# Associations
	belongs_to :order_item
	belongs_to :feature

	# Validations
	validate :value_according_to_type

	protected
		# Checks value is right according to its feature_type.
		# Currently, only checks for :options type  
		def value_according_to_type
			if self.value.present? && self.value != ''
				if self.feature.feature_type == :options
					begin
						FeatureOption.find_by!(id: self.value.to_i, feature_id: self.feature.id)
					rescue ActiveRecord::RecordNotFound => e
						errors.add(:value, e.message)
					end
				end
			end
		end
end
