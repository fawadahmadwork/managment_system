class BankAccountDetail < ApplicationRecord
  belongs_to :employee

  validates :account_title, presence: true, length: { maximum: 100 }
  validates :account_number,
            format: { with: /\A\d{4}-\d{4}-\d{4}-\d{4}\z/, message: "should be in the format 'XXXX-XXXX-XXXX-XXXX'" }

  validates :bank_name, presence: true, length: { maximum: 100 }
  validates :branch_name, presence: true, length: { maximum: 100 }
end
