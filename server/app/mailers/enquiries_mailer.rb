class EnquiriesMailer < ApplicationMailer

  def as_attachment(composed_email)
    file = Tempfile.new('temp_filename')
    output = composed_email.enquiries.map(&:as_json).join('\n')
    file.write(output)
    file.rewind
    attachments['enquiries.txt'] = file.read

    mail(
      bcc: composed_email.suppliers.map(&:email),
      subject: composed_email.subject,
      body: composed_email.body,
      date: DateTime.current
    ) 

    file.close
    file.unlink
  end
end
