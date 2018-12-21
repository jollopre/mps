class Product < ApplicationRecord
  has_many :features

  default_scope { includes(features: [
    :feature_label, :feature_options])
  }

  def as_json(options=nil)
    return super(only: [:id, :name]).merge('features' => features_to_hash) unless options.present?
    super(options)
  end

  private

  def features_to_hash()
    features.reduce({}) do |acc, feature|
      acc["#{feature.id}"] = feature.as_json()
      acc
    end
  end
end
