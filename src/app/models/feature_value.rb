class FeatureValue < ApplicationRecord
	# Associations
	belongs_to :order_item
	belongs_to :feature

	# Validations
	validate :valid_value?

	def serializable_hash(options=nil)
		if options.present?
			super(options)
		else
			super({
				only: [:id, :feature_id, :order_item_id]
			}).merge({ 'value' => self.value_to_feature_type })
		end
	end

	# Converts the value to its feature_type.
	def value_to_feature_type()
		if self.value.present?
			if self.feature.float?
				return self.value.to_f
			elsif self.feature.integer? ||
				self.feature.option?
				return self.value.to_i
			elsif self.feature.string?
				return self.value
			else
				return nil
			end
		end
		return nil
	end

	protected
		# Returns true for a value that conforms to its feature_type, otherwise false
		# If false, this method adds an error message to the the array of errors for the attribute :value
		def valid_value?
			valid = true
			if self.value.present?
				if self.feature.float?
					begin
						Float(self.value)
					rescue ArgumentError => e
						errors.add(:value, e.message)
						valid = false
					end
				elsif self.feature.integer?
					begin
						Integer(self.value)
					rescue ArgumentError => e
						errors.add(:value, e.message)
						valid = false
					end
				elsif self.feature.option?
					begin
						v = Integer(self.value)
						if !self.feature.has_feature_option?(v)
							errors.add(:value, "It does not exist a FeatureOption with id #{self.value}")
							valid = false
						end
					rescue ArgumentError => e
						errors.add(:value, e.message)
						valid = false
					end		
				end
			end
			return valid
		end
end
