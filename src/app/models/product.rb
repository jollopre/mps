class Product < ApplicationRecord
	has_many :features

	def as_json(options=nil)
		if options.nil?
			super({ only: [:id, :name],
					include: {
						features: { only: :feature_type,
							include: { 
								feature_label: {
									only: :name
								},
								feature_options: {
									only: [:id, :name]
								} 
							}
						}
					}
				  })
		else
			super(options)
		end
	end
end
