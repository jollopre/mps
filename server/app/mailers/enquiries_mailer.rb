class EnquiriesMailer < ApplicationMailer

  def as_attachment(composed_email)
    push_attachments(enquiries: composed_email.enquiries, attachments: attachments)
    mail(
      bcc: composed_email.suppliers.map(&:email),
      subject: composed_email.subject,
      body: composed_email.body,
      date: DateTime.current
    ) 
  end

  private

  def generate_descriptors(enquiries)
    enquiries.map do |enquiry|
      filename = "#{enquiry.id}.pdf"
      location = "#{Rails.root}/tmp/#{filename}"
      EnquiryTemplate.new(enquiry).save_as(location)
      { filename: filename, location: location }
    end
  end

  def push_attachments(enquiries:, attachments:)
    descriptors = generate_descriptors(enquiries)
    descriptors.each do |descriptor|
      file_descriptor = File.new(descriptor[:location])
      attachments[descriptor[:filename]] = file_descriptor.read
      file_descriptor.close
    end
  end
end
