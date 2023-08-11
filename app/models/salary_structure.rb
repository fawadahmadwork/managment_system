class SalaryStructure < ApplicationRecord
  belongs_to :employee, optional: :true
  has_many :salary_detail_histories
  before_save :calculate_gross_salary
  before_save :create_salary_detail_history

  private

  def create_salary_detail_history
    return unless changed?

    SalaryDetailHistory.create(
      salary_structure_id: id,
      name: name_was,
      basic_salary: basic_salary_was,
      fuel: fuel_was,
      medical_allownce: medical_allownce_was,
      house_rent: house_rent_was,
      opd: opd_was,
      arrears: arrears_was,
      other_bonus: other_bonus_was,
      gross_salary: gross_salary_was,
      provident_fund: provident_fund_was,
      unpaid_leaves: unpaid_leaves_was,
      net_salary: net_salary_was
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
