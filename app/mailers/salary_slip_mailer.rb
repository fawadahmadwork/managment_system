class SalarySlipMailer < ApplicationMailer
  def send_salary_slip(salary_slip)
    @salary_slip = salary_slip
    @employee = salary_slip.employee

    pdf = generate_pdf(@salary_slip)

    attachments['salary_slip.pdf'] = pdf
    @employee.emails.each do |email_record|
      mail(to: email_record.email, subject: 'Your Salary Slip') do |format|
        format.text { render plain: 'Your salary slip is attached. Click the link above to download it.' }
        format.html { render 'salary_slip_text' }
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
end
