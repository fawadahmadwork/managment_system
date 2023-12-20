class Project < ApplicationRecord
  belongs_to :client
  has_many :weekly_hours, dependent: :destroy
  validates :name, presence: true
  # validates :type, presence: true
  validates :billing_type, presence: true
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fee_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 40 }, allow_nil: true
  before_save :set_date_completed_if_closed

    def set_date_completed_if_closed
    if status_changed?
      if status == 'Closed'
        self.date_completed = Time.zone.now
      elsif %w[Active Inactive].include?(status)
        self.date_completed = nil
      end
    end
  end

end