namespace :suppliers do
  desc 'Imports suppliers from csv file path specified'
  task :csv_importer, [:path_file] => :environment do |t, args|
    Supplier.csv_importer(args[:path_file])
  end
end
