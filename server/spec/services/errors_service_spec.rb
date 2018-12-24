require 'rails_helper'

RSpec.describe ErrorsService do
  describe '.do' do
    context 'when an errorable exception is received' do
      ErrorableException = Class.new do
        include ErrorsService::Adapters::Adapter

        def errors
          ['Attribute1 must be present']
        end

        def status
          400
        end
      end

      it 'returns a hash with errors' do
        errorable_exception = ErrorableException.new  

        result = described_class.do(errorable_exception)

        expect(result).to eq({
          errors: [
            { status: 400, detail: 'Attribute1 must be present' }
          ]
        })
      end
    end
  end
end
