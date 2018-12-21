class FeatureOption < ApplicationRecord
  belongs_to :feature

  def as_json(options=nil)
    return super(only: [:id, :name]) unless options.present?
    super(options)
  end
end
