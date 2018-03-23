class Customer < ApplicationRecord
	has_many :quotations

	scope :search, ->(term) {
		# Using heredoc
		query = <<-QUERY
			LOWER(reference) LIKE :term OR
			LOWER(email) LIKE :term OR
			LOWER(contact_name) LIKE :term OR
			LOWER(contact_surname) LIKE :term
			QUERY
		where(query, { term: "%#{term.downcase}%" })
	}
	def serializable_hash(options = nil)
		if options.present?
			super(options)
		else
			super({ except: [:created_at, :updated_at]})
		end
	end
end