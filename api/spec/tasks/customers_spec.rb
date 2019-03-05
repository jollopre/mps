require 'rails_helper'

describe 'rake customers:csv_importer', type: :task do
  it 'calls Customer.csv_importer' do
    expect(Customer).to receive(:csv_importer).with('spec/assets/customers.csv')

    task.execute(path_file: 'spec/assets/customers.csv')
  end
end
