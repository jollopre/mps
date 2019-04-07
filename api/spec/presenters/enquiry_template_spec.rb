require 'rails_helper'

RSpec.describe EnquiryTemplate do
  describe '.new' do
    let(:customer) do
      create(:ref1, company_name: 'REF1 COMPANY', address: 'My Street')
    end
    let(:quotation) do
      create(:quotation, customer: customer)
    end
    let(:product) do
      create(:plastic_carrier_bag)
    end
    let(:current_user) do
      create(:someone, name: 'Jose', surname: 'Lloret', email: 'someone@somewhere.com')
    end
    let(:enquiry) do
      create(:enquiry, quotation: quotation, product: product)
    end
    let(:text_analyzed) do
      rendered_pdf = described_class.new(enquiry: enquiry, current_user: current_user).render
      PDF::Inspector::Text.analyze(rendered_pdf)
    end

    it 'Date is set to updated_at UTC format from enquiry' do
      result = text_analyzed.strings

      expect(result).to include(enquiry.updated_at.utc.to_s)
    end

    it "Customer is set to customer's company name" do
      result = text_analyzed.strings

      expect(result).to include('REF1 COMPANY')
    end

    it "Ref No is set to customer's reference" do
      result = text_analyzed.strings

      expect(result).to include('REF1')
    end

    it "Enquiry No is set to enquiry's id" do
      result = text_analyzed.strings

      expect(result).to include(enquiry.id.to_s)
    end

    it "Contact is set to current_user's full_name" do
      result = text_analyzed.strings

      expect(result).to include('Jose Lloret')
    end
    
    it "Email is set to current_user's email" do
      result = text_analyzed.strings

      expect(result).to include('someone@somewhere.com')
    end

    it "Delivery Adress is set to customer's address" do
      result = text_analyzed.strings

      expect(result).to include('My Street')
    end

    context 'when save_as is invoked' do
      let(:file_path) do
        'tmp/test.pdf'
      end
      before do
        File.delete(file_path) if File.exist?(file_path)
      end

      it 'the pdf gets stored' do
        described_class.new(enquiry: enquiry, current_user: current_user).save_as(file_path)

        result = File.exist?(file_path)
        expect(result).to eq(true)
      end
    end
  end
end
