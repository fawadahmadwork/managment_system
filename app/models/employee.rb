class Employee < ApplicationRecord
  has_one :salary_structure
  has_many :salary_structure_histories, through: :salary_structure
end
