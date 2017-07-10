class Customer < ApplicationRecord
	has_many :orders
	def serializable_hash(options = nil)
		if options.present?
			super(options)
		else
			super({ except: [:created_at, :updated_at]})
		end
	end
end
