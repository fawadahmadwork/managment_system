class SalarySlip < ApplicationRecord
  belongs_to :employee
  has_one_attached :pdf_attachment
  after_create :send_salary_slip_email
  def send_salary_slip_email
    SalarySlipMailer.send_salary_slip(self).deliver_now
  end
end
