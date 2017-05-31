class FeatureValue < ApplicationRecord
	# Associations
	belongs_to :order_item
	belongs_to :feature

	# Validations
	validate :value_conforms_to_feature_type

	def serializable_hash(options=nil)
		if options.present?
			super(options)
		else
			super({
				only: [:id, :feature_id, :order_item_id]
			}).merge({:value => self.value_to_feature_type})
		end
	end

	# Converts the value to its feature_type. If string_formatted is true stringifies the value
	# rather than returning its type
	def value_to_feature_type(string_formatted = false)
		if self.value.present?
			if self.feature.float?
				return string_formatted ? self.value : self.value.to_f
			elsif self.feature.integer?
				return string_formatted ? self.value : self.value.to_i
			elsif self.feature.option?
				if !string_formatted
					return self.value.to_i
				end
				fo = self.feature.get_feature_option_for(self.value.to_i)
				return fo.nil? ? nil : fo.name
			elsif self.feature.string?
				return self.value
			else
				return nil
			end
		end
		return nil
	end

	protected
		# Checks whether or not the value conforms to its feature_type
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
						if !self.feature.has_feature_option?(self.value.to_i)
							errors.add(:value, "It does not exist a FeatureOption with id #{self.value}")
						end
					rescue ArgumentError => e
						errors.add(:value, e.message)
					end		
				end
			end
		end
end
