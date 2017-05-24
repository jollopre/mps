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
	
	# Gets the value formatted according its feature type. This method is useful for pdf printing
	def formatted_value
		if self.value.present?
			if self.feature.float?
				return self.value.to_f
			elsif self.feature.integer?
				return self.value.to_i
			elsif self.feature.option?
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
						FeatureOption.find_by!(id: self.value, feature_id: self.feature.id)
					rescue ActiveRecord::RecordNotFound => e
						errors.add(:value, e.message)
					end			
				end
			end
		end
		# Converts the value to its feature_type. This method is used to generate JSON object
		def value_to_feature_type
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
end
