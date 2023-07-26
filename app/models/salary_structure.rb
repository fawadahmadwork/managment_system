class SalaryStructure < ApplicationRecord
  belongs_to :employee
  has_many :salary_structure_histories
  before_save :create_salary_structure_history

  private

  def create_salary_structure_history
    # Create a new SalaryStructureHistory record with the previous attribute values
    return unless changed?

    SalaryStructureHistory.create(
      salary_structure_id: id,
      name: name_was,
      salary: salary_was,
      allowances: allowances_was
    )
  end
end
