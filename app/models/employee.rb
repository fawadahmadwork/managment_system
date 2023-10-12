class Employee < ApplicationRecord
  has_many :todo_items, dependent: :destroy
  accepts_nested_attributes_for :todo_items, allow_destroy: true
  has_many :todo_lists, dependent: :destroy
  accepts_nested_attributes_for :todo_lists, allow_destroy: true
  has_one :salary_structure, dependent: :destroy
  has_many :salary_detail_histories, through: :salary_structure, dependent: :destroy
  has_many :salary_slips, dependent: :destroy
  has_one_attached :avatar
  has_many :emails, dependent: :destroy
  accepts_nested_attributes_for :emails, allow_destroy: true
  has_many :phone_numbers, dependent: :destroy
  accepts_nested_attributes_for :phone_numbers, allow_destroy: true
  has_many :bank_account_details, dependent: :destroy
  accepts_nested_attributes_for :bank_account_details, allow_destroy: true

  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
  validates :age, presence: true
  validates :gender, presence: true, inclusion: { in: %w[Male Female] }
  validates :date_of_birth, presence: true
  validate :date_of_birth_within_range
  validates :date_of_joining, presence: true
  validates :address, presence: true, length: { maximum: 100 }
  validates :national_id_card, presence: true, length: { maximum: 15 },
                               format: { with: /\A\d{5}-\d{7}-\d{1}\z/, message: "should be in the format '12345-1234567-1'" },
                               uniqueness: true, if: :national_id_card_present?
  validates :designation, presence: true
  # validates :avatar, presence: true
  validates :department, presence: true
  validates :employment_status, presence: true
  validates :employment_type, presence: true
  # validates :starting_salary, numericality: { greater_than_or_equal_to: 0 }
  validates :signup_bonus, presence: true, numericality: { greater_than_or_equal_to: 0 }
  before_save :capitalize_names
  after_save :update_related_salary_structure
 def update_salary_structure_from_template
    template = SalaryStructure.find_by(employee_id: nil, name: self.designation)
    if template
      self.salary_structure.update(
        basic_salary: template.basic_salary,
        fuel: template.fuel,
        medical_allownce: template.medical_allownce,
        house_rent: template.house_rent,
        opd: template.opd,
        arrears: template.arrears,
        other_bonus: template.other_bonus,
        gross_salary: template.gross_salary,
        provident_fund: template.provident_fund,
        net_salary: template.net_salary
      )
    end
  end



  private

  def date_of_birth_within_range
    return if date_of_birth.blank? # Skip validation if date_of_birth is blank

    min_date = Date.new(1970, 1, 1)
    max_date = Date.new(2005, 12, 31)

    return if date_of_birth.between?(min_date, max_date)

    errors.add(:date_of_birth, 'must be between 1970 and 2005')
  end

  def update_related_salary_structure
    return unless saved_change_to_first_name? || saved_change_to_last_name?

    related_salary_structure = SalaryStructure.find_by(employee: self)

    return unless related_salary_structure

    new_name = "#{first_name} #{last_name}"
    related_salary_structure.update(name: new_name)
  end

  def capitalize_names
    self.first_name = first_name.capitalize if first_name.present?
    self.last_name = last_name.capitalize if last_name.present?
  end

  def national_id_card_present?
    national_id_card.present?
  end
end
