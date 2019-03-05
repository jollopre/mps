require 'csv'

module Customers
  module CSVImporter
    NO_EMAIL = 'noone@nowhere.com'.freeze
    def csv_importer(path_file)
      logger = Logger.new(STDOUT)
      CSV.foreach(path_file, headers: :first_row) do |row|
        reference = row.field('Reference')
        email = row.field('Email')
        customer = Customer.new(
          company_name: row.field('Company Name'),
          reference: reference,
          address: row.field('Address'),
          telephone: row.field('Telephone'),
          email: email,
          city: row.field('Town'),
          postcode: row.field('PostCode'),
          country: row.field('Country')
        )
        unless customer.valid?
          customer.email = NO_EMAIL
          logger.debug("email: #{email} invalid for customer reference: #{reference}")
        end
        customer.save!
      end
    end
  end
end
