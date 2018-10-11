class Feature < ApplicationRecord
  # Relations
  belongs_to :product
  belongs_to :feature_label
  has_many :feature_options
  has_many :feature_values

  enum feature_type: [:float, :integer, :option, :string]

  # Validations
  validates :feature_type, inclusion: {
    in: self.feature_types.keys(),
    message: '%{value} is not a valid feature_type.'
  }

  def has_feature_option?(option_id)
    return self.feature_option_ids.include?(option_id)
  end

  def get_feature_option_for(option_id)
    return self.feature_options.find { |fo| fo.id == option_id }
  end

  def serializable_hash(options = nil)
    if options.present?
      super(options)
    else
      super({
        only: [:id, :feature_type],
        include: [:feature_label]
      }).merge("feature_options" => feature_options_to_h)
    end
  end

  private

  def feature_options_to_h
    feature_options.reduce({}) do |acc, fo|
      acc[fo.id] = fo.as_json
      acc
    end
  end
end
