class WeeklyHour < ApplicationRecord
  

 after_validation :set_week_number, on: :create

  def set_week_number
    # Check if date is present before calculating week number
    return unless date.present?

    # Calculate week number based on the date_range method
    start_date = date.beginning_of_week(:monday)
    week_number = (start_date.day + 6) / 7
     week_suffix = case week_number % 10
                when 1 then 'st'
                when 2 then 'nd'
                when 3 then 'rd'
                else 'th'
                end

    # Set the week_number attribute
    self.week_number = "#{week_number}#{week_suffix} week  #{start_date.strftime('%b')}"
  end

  belongs_to :project
 before_validation :set_default_date
  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :external_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  before_validation :set_date
  before_save :set_week_date


  def set_date
    self.date ||= Time.now if date.blank?
  end
  def set_week_date
    self.week_date ||= date.beginning_of_week(:monday)
  end

  def set_default_date
    self.date ||= created_at.to_date if created_at.present?
  end

  def external_cost
    hours * external_rate
  end

  def total_amount
    hours * project.rate
  end

  def fee
    (hours * project.rate * project.fee_percentage) / 100
  end

  def net_amount
    total_amount - external_cost - fee
  end


def date_range
  start_date = date.beginning_of_week(:monday)
  end_date = start_date + 4

  week_number = (start_date.day + 6) / 7
  week_suffix = case week_number % 10
                when 1 then 'st'
                when 2 then 'nd'
                when 3 then 'rd'
                else 'th'
                end

  "#{week_number}#{week_suffix} week of  #{start_date.strftime('%b')} (#{start_date.strftime('%d %b')} to #{end_date.strftime('%d %b')})"
end


end