require 'rails_helper'

describe 'rake suppliers:csv_importer', type: :task do
  it 'calls Supplier.csv_importer' do
    expect(Supplier).to receive(:csv_importer).with('spec/assets/suppliers.csv')

    task.execute(path_file: 'spec/assets/suppliers.csv')
  end
end
