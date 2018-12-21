class Feature < ApplicationRecord

  belongs_to :product
  belongs_to :feature_label
  has_many :feature_options
  has_many :feature_values

  enum feature_type: [:float, :integer, :option, :string]

  def feature_option_id?(id)
    feature_option_ids.include?(id)
  end

  def find_feature_option_by_id(id)
    return self.feature_options.find { |fo| fo.id == id }
  end

  def as_json(options = nil)
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
