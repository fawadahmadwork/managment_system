class PhoneNumber < ApplicationRecord
  belongs_to :employee
  validates :phone_number, presence: true
  validate :validate_phone_number_format

  private

  def validate_phone_number_format
    return if phone_number.blank?

    return if /\A\d{4}-\d{7}\z/.match?(phone_number)

    errors.add(:phone_number, 'must be in the format 1234-5678901')
  end
end
