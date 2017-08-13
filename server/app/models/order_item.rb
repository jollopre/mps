class OrderItem < ApplicationRecord
	# Associations
	belongs_to :order
	belongs_to :product
	has_many :feature_values
	has_many :features, through: :feature_values

	# Validations
	validates :quantity, numericality: { only_integer: true }
	
	# Callbacks
	after_create :create_feature_values

	def feature_values_to_hash()
		self.feature_values.reduce({}) { |h, fv| h["#{fv.id}"] = fv.as_json(); h }
	end

	def serializable_hash(options = nil)
		if options.present?
			super(options)
		else
			super({
					only: [:id, :quantity, :order_id, :product_id],
				}).merge(feature_values: feature_values_to_hash)
		end
	end

	protected
		# Creates a SQL query for inserting multiple rows simultaneously. The reason of using raw SQL query is due
		# to the fact that ActiveRecord::Associations::CollectionProxy does not support bulk insert
		def create_feature_values
			datetime = DateTime.now()
			fv = self.product.features.map { |f| "('', #{f.id}, #{self.id}, '#{datetime}', '#{datetime}')" }.join(",")
			ActiveRecord::Base.connection
				.execute("INSERT INTO feature_values (value, feature_id, order_item_id, created_at, updated_at) VALUES #{fv}")
		end
end
