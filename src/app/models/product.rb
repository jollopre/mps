class Product < ApplicationRecord
	has_many :features

	def serializable_hash(options=nil)
		if options.present?
			super(options)
		else
			super({ only: [:id, :name],
					include: :features})
		end
	end
end
