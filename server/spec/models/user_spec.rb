require 'rails_helper'

RSpec.describe User do
  let(:user) do
    create(:someone, password: 'secret_password')
  end

  describe '#valid_password?' do
    context 'when password is similar to the hex-encoded string stored' do
      it 'returns true' do
        result = user.valid_password?('secret_password')

        expect(result).to eq(true)
      end
    end

    context 'when password is NOT similar to the hex-encoded string stored' do
      it 'returns false' do
        result = user.valid_password?('wadus')

        expect(result).to eq(false)
      end
    end
  end

  describe '#generate_token' do
    context 'when the user has not been created first' do
      it 'returns nil' do
        user = build(:someone)

        result = user.generate_token

        expect(result).to be_nil
      end
    end

    context 'when the user is stored' do
      before(:each) do
        allow(SecureRandom).to receive(:base64).and_return('a_token')
        allow(user).to receive(:update_columns)
      end
      it 'updates the user record with the new token' do
        result = user.generate_token

        expect(user).to have_received(:update_columns).with(token: 'a_token', token_created_at: anything, updated_at: anything)
      end

      it 'returns the new token generated' do
        result = user.generate_token

        expect(result).to eq('a_token')
      end
    end
  end

  describe '#invalide_token' do
    context 'when the user has not been created first' do
      it 'returns false' do
        user = build(:someone)

        result = user.invalidate_token

        expect(result).to eq(false)
      end
    end

    context 'when the user is stored' do
      before(:each) do
        allow(user).to receive(:update_columns)
      end

      it 'updates the user record with nil token' do
        user.invalidate_token

        expect(user).to have_received(:update_columns).with(token: nil, token_created_at: nil, updated_at: anything)
      end

      it 'returns true' do
        result = user.invalidate_token

        expect(result).to eq(true)
      end
    end
  end

  describe '.before_save' do
    it 'encrypts the password' do
      allow(Digest::SHA2).to receive(:hexdigest).and_return('hex_coded_hash')
      user.password = 'wadus'

      user.save

      expect(user.password).to eq('hex_coded_hash')
    end
  end

  describe '.validates' do
    context 'when email is not present' do
      it 'raises ActiveRecord::RecordInvalid' do
        user.email = nil

        expect do
          user.validate!
        end.to raise_error(ActiveRecord::RecordInvalid, /Email can't be blank/)
      end
    end

    context 'when password is not present' do
      it 'raises ActiveRecord::RecordInvalid' do
        user.password = nil

        expect do
          user.validate!
        end.to raise_error(ActiveRecord::RecordInvalid, /Password can't be blank/)
      end
    end
  end
end
