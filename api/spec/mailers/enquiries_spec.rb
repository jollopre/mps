require "rails_helper"

RSpec.describe EnquiriesMailer, type: :mailer do
  describe "#do" do
    let(:supplier1) do
      create(:supplier, email: 'supplier1@somewhere.com')
    end
    let(:enquiry1) do
      enquiry1 = create(:enquiry1)
      width_feature = create(:width)
      create(:feature_value, enquiry: enquiry1, feature: width_feature)
      enquiry1
    end
    let(:composed_email) { create(:composed_email, subject: 'foo', body: 'bar', enquiries: [enquiry1], suppliers: [supplier1]) }
    let(:user) do
      create(:someone)
    end
    let(:mail) { EnquiriesMailer.do(composed_email: composed_email, current_user: user) }

    it "renders the headers" do
      expect(mail.subject).to eq("foo")
      expect(mail.bcc).to eq(["supplier1@somewhere.com"])
      expect(mail.from).to include(include("no-reply@"))
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("bar")
    end

    it 'includes attachments for each enquiry' do
      expect(mail.attachments).not_to be_empty
    end
  end
end
