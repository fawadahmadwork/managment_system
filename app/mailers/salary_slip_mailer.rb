class SalarySlipMailer < ApplicationMailer
  def send_salary_slip(salary_slip)
    @salary_slip = salary_slip
    @employee = salary_slip.employee

    pdf = generate_pdf(@salary_slip)

    attachments['salary_slip.pdf'] = pdf

    mail(to: @employee.emails.first, subject: 'Your Salary Slip') do |format|
      format.text { render plain: 'Your salary slip is attached. Click the link below to download it.' }
      format.html { render layout: nil } # Render without layout for HTML format
    end
  end

  private

  def generate_pdf(_salary_slip)
    WickedPdf.new.pdf_from_string(
      render_to_string(
        pdf: 'salary_slip_mailer/salary_slip_pdf.html.erb',
        layout: 'layouts/pdf'
      )
    )
  end
end
