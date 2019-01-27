class FeatureValue < ApplicationRecord
  belongs_to :enquiry
  belongs_to :feature

  validate :must_be_valid_type_for_value

  DEFAULT_VALUE = "''".freeze
  BULK_INSERT_DEFAULT_VALUE_QUERY = lambda do |features, enquiry|
    now = DateTime.now
    values = features.map do |feature|
      "(#{DEFAULT_VALUE}, #{feature.id}, #{enquiry.id}, '#{now}', '#{now}')"
    end.join(',')
    insert_statement = "INSERT INTO feature_values (value, feature_id, enquiry_id, created_at, updated_at) VALUES #{values}"
    ActiveRecord::Base.connection.execute(insert_statement) if values.present?
  end.freeze

  def as_json(options=nil)
    if options.present?
      super(options)
    else
      super({
        only: [:id, :feature_id, :enquiry_id]
      }).merge({ 'value' => deserialize_value })
    end
  end

  private

  def deserialize_value
    return unless value.present?
    feature = self.feature
    return value.to_i if feature.integer? || feature.option?
    return value.to_f if feature.float?
    value
  end

  def must_be_valid_type_for_value
    return unless value.present?
    return Float(value) if feature.float?
    return Integer(value) if feature.integer?
    if feature.option?
      coerced = Integer(value)
      errors.add(:value, 'Value is not included in the feature_option_ids for feature') unless feature.feature_option_id?(coerced)
    end
  rescue ArgumentError
    feature_type = feature.feature_type
    errors.add(:value, "Value invalid value for #{feature_type} feature")
  end
end
