class PhoneNumber < ApplicationRecord
  belongs_to :employee

  validates :phone_number, presence: true, uniqueness: true,
                           format: { with: /\A\d{4}-\d{7}\z/, message: 'must be in the format 0300-1234567' },
                           uniqueness: true
end
