namespace :customers do
  desc 'Imports customers from csv file path specified'
  task :csv_importer, [:path_file] => :environment do |t, args|
    Customer.csv_importer(args[:path_file])
  end
end
