class FeatureOption < ApplicationRecord
	belongs_to :feature

	def serializable_hash(options=nil)
		if options.present?
			super(options)
		else
			super({ only: [:id, :name]})
		end
	end

	def to_s
		self.name
	end
end
