class Employee < ApplicationRecord
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

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, presence: true
  validates :gender, presence: true, inclusion: { in: %w[Male Female] }
  validates :date_of_birth, presence: true
  validates :date_of_joining, presence: true
  validates :address, presence: true, length: { maximum: 200 }
  validates :national_id_card, length: { maximum: 15 },
                               format: { with: /\A\d{5}-\d{7}-\d{1}\z/, message: "should be in the format '12345-1234567-1'" },
                               uniqueness: true
  validates :designation, presence: true
  validates :avatar, presence: true
  validates :department, presence: true
  validates :employment_status, presence: true
  validates :employment_type, presence: true
  before_save :capitalize_names

  private

  def capitalize_names
    self.first_name = first_name.capitalize if first_name.present?
    self.last_name = last_name.capitalize if last_name.present?
  end
end
