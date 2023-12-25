class Client < ApplicationRecord
  has_many :projects, dependent: :destroy
  before_validation :capitalize_name
  validates :name, presence: true
  validates :email, uniqueness: { allow_nil: true }, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, if: -> { email.present? }
  validates :phone, uniqueness: { allow_nil: true }, if: -> { phone.present? }

   def capitalize_name
    self.name = name.capitalize if name.present?
  end
end
