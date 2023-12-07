class Project < ApplicationRecord
  belongs_to :client
  has_many :weekly_hours, dependent: :destroy
  validates :name, presence: true
  # validates :type, presence: true
  validates :billing_type, presence: true
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fee_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 40 }, allow_nil: true
end