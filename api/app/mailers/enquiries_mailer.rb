class EnquiriesMailer < ApplicationMailer
  attr_reader :enquiries
  attr_reader :current_user

  def do(composed_email: , current_user:)
    @enquiries = composed_email.enquiries
    @current_user = current_user
    push_attachments
    mail(
      bcc: composed_email.suppliers.map(&:email),
      subject: composed_email.subject,
      body: composed_email.body,
      date: DateTime.current
    ) 
  end

  private

  def generate_descriptors
    enquiries.map do |enquiry|
      filename = "#{enquiry.id}.pdf"
      location = "#{Rails.root}/tmp/#{filename}"
      EnquiryTemplate.new(enquiry: enquiry, current_user: current_user).save_as(location)
      { filename: filename, location: location }
    end
  end

  def push_attachments
    descriptors = generate_descriptors
    descriptors.each do |descriptor|
      file_descriptor = File.new(descriptor[:location])
      attachments[descriptor[:filename]] = file_descriptor.read
      file_descriptor.close
    end
  end
end
