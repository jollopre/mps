require "rails_helper"

RSpec.describe EnquiriesMailer, type: :mailer do
  fixtures :enquiries
  fixtures :suppliers

  describe "as_attachment" do
    let(:composed_email) {
      ce = ComposedEmail.new(subject: 'foo', body: 'bar')
      ce.enquiries << enquiries(:enquiry1)
      ce.suppliers << suppliers(:supplier1)
      ce
    }
    let(:mail) { EnquiriesMailer.as_attachment(composed_email) }

    it "renders the headers" do
      expect(mail.subject).to eq("foo")
      expect(mail.bcc).to eq(["pepe@ref1.com"])
      expect(mail.from).to eq(["no-reply@mail.com"])
    end


    it "renders the body" do
      expect(mail.body.encoded).to match("bar")
    end
  end

end
