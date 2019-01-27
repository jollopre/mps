class Supplier < ApplicationRecord
  has_and_belongs_to_many :composed_emails

  def as_json(options = nil)
    return super(except: [:created_at, :updated_at]) unless options.present?
    super(options)
  end
end
