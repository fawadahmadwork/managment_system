class BankAccountDetail < ApplicationRecord
  belongs_to :employee
  validates :bank_name, presence: true, length: { maximum: 100 }
  validates :account_title, presence: true, length: { maximum: 30 }
  validates :branch_code, presence: true, numericality: { only_integer: true }, length: { is: 4 }
  validates :account_number, presence: true, length: { in: 12..24 }, uniqueness: true

  validates :IBAN, presence: true,
                   format: { with: /\APK\d{2}[A-Za-z]{4}\d{16}\z/, message: "should be in the format 'PK36SCBL0000001123456702'" }, uniqueness: true
end
