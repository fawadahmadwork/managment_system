class SalarySlipMailer < ApplicationMailer
  def send_salary_slip(salary_slip)
    @salary_slip = salary_slip
    @employee = salary_slip.employee

    pdf = generate_pdf(@salary_slip)

    # Attach the PDF using Active Storage
    pdf_blob = create_pdf_blob(pdf)
    @salary_slip.pdf_attachment.attach(pdf_blob)

    @employee.emails.each do |_email_record|
      attachments['salary_slip.pdf'] = {
        mime_type: 'application/pdf',
        content: pdf
      }
      # Iterate through each email record of the employee
      @employee.emails.each do |email_record|
        mail(to: email_record.email, subject: 'Your Salary Slip') do |format|
          format.text { render plain: 'Your salary slip is attached. Click the link above to download it.' }
          format.html { render 'salary_slip_text' }
        end
      end
    end
  end

  private

  def generate_pdf(_salary_slip)
    WickedPdf.new.pdf_from_string(
      render_to_string(
        pdf: 'salary_slip_mailer/send_salary_slip.html.erb',
        layout: 'layouts/pdf'
      )
    )
  end

  def create_pdf_blob(pdf_content)
    ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(pdf_content),
      filename: 'salary_slip.pdf',
      content_type: 'application/pdf'
    )
  end
end
