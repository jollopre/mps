require 'csv'

module Suppliers
  module CSVImporter
    def csv_importer(path_file)
      logger = Logger.new(STDOUT)
      CSV.foreach(path_file, headers: :first_row) do |row|
        reference = row.field('Reference')
        supplier = Supplier.new(
          reference: reference,
          company_name: row.field('Company / Name'),
          contact: row.field('Contact') || '',
          email: row.field('Email'),
          telephone: row.field('Telephone'),
          address: row.field('Address'),
          city: row.field('Town'),
          postcode: row.field('Postcode'),
          country: row.field('Country')
        )
        if supplier.valid?
          supplier.save
        else
          p 'else'
          logger.debug("#{supplier.errors.messages}, for supplier reference: #{reference}")
        end
      end
    end
  end
end
