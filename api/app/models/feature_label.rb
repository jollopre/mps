class FeatureLabel < ApplicationRecord
  has_many :features

  def as_json(options = nil)
    return super({ only: :name }) unless options.present?
    super(options)
  end
end
