class Enquiry < ApplicationRecord
  # Associations
  belongs_to :quotation
  belongs_to :product
  has_many :feature_values, dependent: :destroy
  has_many :features, through: :feature_values
  has_and_belongs_to_many :composed_emails

  # Validations
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity2, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity3, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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
        only: [:id, :quantity, :quantity2, :quantity3, :quotation_id, :product_id],
      }).merge(feature_values: feature_values_to_hash)
    end
  end

  protected

  def create_feature_values
    datetime = DateTime.now()
    fv = self.product.features.map { |f| "('', #{f.id}, #{self.id}, '#{datetime}', '#{datetime}')" }.join(",")
    if fv.present?
      ActiveRecord::Base.connection
      .execute("INSERT INTO feature_values (value, feature_id, enquiry_id, created_at, updated_at) VALUES #{fv}")
    end
  end
end
