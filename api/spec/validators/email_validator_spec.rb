require 'rails_helper'

RSpec.describe EmailValidator do
  class ClassWithEmail
    include ActiveModel::Model

    attr_accessor :email
  end

  describe '#validate_each' do
    let(:email_validator) do
      described_class.new(attributes: [:email])
    end

    context 'when the record is valid' do
      let(:record) do
        ClassWithEmail.new(email: 'someone@somewhere.com')
      end

      it 'does not append message to record errors' do
        result = email_validator.validate_each(record, :email, record.email)

        email_attribute = record.errors[:email]
        expect(email_attribute).to be_empty
      end
    end

    context 'when the record is invalid' do
      let(:records) do
        [
          ClassWithEmail.new(email: nil),
          ClassWithEmail.new(email: ''),
          ClassWithEmail.new(email: '@somewhere.com'),
          ClassWithEmail.new(email: 'a@'),
          ClassWithEmail.new(email: 'a@.com'),
          ClassWithEmail.new(email: 'a@somewhere'),
          ClassWithEmail.new(email: 'a@somewhere.'),
          ClassWithEmail.new(email: 'a@somewhere.com.'),
          ClassWithEmail.new(email: 'a@somewhere.c')
        ]
      end

      it 'appends default message to record errors' do
        records.each do |record|
          result = email_validator.validate_each(record, :email, record.email)

          email_attribute = record.errors[:email]
          expect(email_attribute).to eq(['is invalid'])
        end
      end

      context 'and options message is passed' do
        let(:email_validator) do
          described_class.new(attributes: [:email], message: 'wadus')
        end

        it 'appends custom message to record errors' do
          records.each do |record|
            result = email_validator.validate_each(record, :email, record.email)

            email_attribute = record.errors[:email]
            expect(email_attribute).to eq(['wadus'])
          end
        end
      end
    end
  end
end
