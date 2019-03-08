class Supplier < ApplicationRecord
  extend Suppliers::CSVImporter

  has_and_belongs_to_many :composed_emails

  validates :email, presence: true, email: true

  def as_json(options = nil)
    return super(except: [:created_at, :updated_at]) unless options.present?
    super(options)
  end
end
