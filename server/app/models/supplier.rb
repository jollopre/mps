class Supplier < ApplicationRecord
	has_and_belongs_to_many :composed_emails

	def serializable_hash(options = nil)
		if options.present?
			super(options)
		else
			super(except: [:created_at, :updated_at])
		end
	end
end
