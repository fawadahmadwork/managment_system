class Client < ApplicationRecord
  has_many :projects, dependent: :destroy
  validates :name, presence: true
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :phone,  uniqueness: true
end
