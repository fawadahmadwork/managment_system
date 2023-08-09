class SalaryStructure < ApplicationRecord
  belongs_to :employee, optional: :true
  before_save :calculate_gross_salary
  before_save :create_salary_detail_history

  private

  def create_salary_detail_history
   
    return unless changed?

    SalaryDetailHistory.create(
      employee_id: id,
      name: name_was,
      basic_salary: basic_salary_was
    )
  end

  def calculate_gross_salary
    self.gross_salary = (basic_salary || 0) +
                        (fuel || 0) + (medical_allownce || 0) +
                        (house_rent || 0) + (opd || 0) +
                        (arrears || 0) + (other_bonus || 0)

    self.net_salary = gross_salary - (provident_fund || 0)
  end
end
