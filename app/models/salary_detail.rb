class SalaryDetail < ApplicationRecord
  belongs_to :employee
  has_many :salary_detail_histories
  before_save :create_salary_detail_history

  private

  def create_salary_detail_history
    # Create a new SalaryStructureHistory record with the previous attribute values
    return unless changed?

    SalaryDetailHistory.create(
      salary_detail_id: id,
      name: name_was,
      salary: salary_was,
      allowances: allowances_was
    )
  end
end
