class Customer < ApplicationRecord
  extend Customers::CSVImporter

  has_many :quotations

  scope :search, ->(term) {
    query = <<-QUERY
                        LOWER(reference) LIKE :term OR
                        LOWER(email) LIKE :term OR
                        LOWER(contact_name) LIKE :term OR
                        LOWER(contact_surname) LIKE :term
    QUERY
    where(query, { term: "%#{term.downcase}%" })
  }

  validates :email, email: true

  def as_json(options = nil)
    return super({ except: [:created_at, :updated_at]}) unless options
    super(options)
  end
end
