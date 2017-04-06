class FeatureValue < ApplicationRecord
	# Associations
	belongs_to :order_item
	belongs_to :feature

	# Validations
	validate :value_conforms_to_feature_type

	def as_json(options=nil)
		if options.nil?
			super({
				only: [:order_item_id, :feature_id]
			}).merge({:value => self.value_to_feature_type})
		else
			super(options)
		end
	end
	
	protected
		# Checks whether or not the value conforms to its feature_type,
		# TODO, investigate how to raise ActiveRecord::RecordInvalid when checking fails
		def value_conforms_to_feature_type
			if self.value.present?
				if self.feature.float?
					begin
						Float(self.value)
					rescue ArgumentError => e
						errors.add(:value, e.message)
					end
				elsif self.feature.integer?
					begin
						Integer(self.value)
					rescue ArgumentError => e
						errors.add(:value, e.message)
					end
				elsif self.feature.option?
					begin
						FeatureOption.find_by!(id: self.value, feature_id: self.feature.id)
					rescue ActiveRecord::RecordNotFound => e
						errors.add(:value, e.message)
					end			
				end
			end
		end
		# Converts the value to its feature_type
		def value_to_feature_type
			if self.value.present?
				if self.feature.float?
					return self.value.to_f
				elsif self.feature.integer? ||
					self.feature.option?
					return self.value.to_i
				elsif self.feature.string?
					return self
				else
					return nil
				end
			end
			return nil
		end
end
