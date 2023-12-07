class Client < ApplicationRecord
  has_many :projects, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :phone, presence: true, uniqueness: true
end
