class Enquiry < ApplicationRecord
  belongs_to :quotation
  belongs_to :product
  has_many :feature_values, dependent: :destroy
  has_many :features, through: :feature_values
  has_and_belongs_to_many :composed_emails

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity2, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :quantity3, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :insert_default_value_every_feature

  def as_json(options = nil)
    return super({
      only: [:id, :quantity, :quantity2, :quantity3, :quotation_id, :product_id],
    }).merge('feature_values' => feature_values_to_h) unless options
    super(options)
  end

  private

  def insert_default_value_every_feature
    FeatureValue::BULK_INSERT_DEFAULT_VALUE_QUERY.call(self.product.features, self)
  end

  def feature_values_to_h()
    self.feature_values.reduce({}) { |h, fv| h["#{fv.id}"] = fv.as_json(); h }
  end
end
