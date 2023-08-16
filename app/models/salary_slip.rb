class SalarySlip < ApplicationRecord
  belongs_to :employee
  before_save :calculate_gross_salary

  def calculate_gross_salary
    self.gross_salary = (basic_salary || 0) +
                        (fuel || 0) + (medical_allownce || 0) +
                        (house_rent || 0) + (opd || 0) +
                        (arrears || 0) + (other_bonus || 0)

    self.net_salary = gross_salary - (provident_fund || 0)
  end
end
