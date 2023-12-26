class WeeklyHour < ApplicationRecord
  belongs_to :project
  
  attr_accessor :show_external_rate

  before_validation :set_rate_from_project, on: :create
  before_validation :set_fee_percentage_from_project, on: :create

  before_validation :set_default_date
  before_validation :set_date
  after_validation :set_week_number, on: :create
  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :external_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
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
  if hours && project&.rate && project&.fee_percentage
    (hours * project.rate * project.fee_percentage) / 100
  else
    0  # or any default value you prefer when one of the values is nil
  end
end


  def net_amount
    total_amount - external_cost - fee
  end

  def set_rate_from_project
    # Set the rate to be the same as the associated project's rate
    self.rate = project.rate if project.present?
  end


   def set_fee_percentage_from_project
    # Set the rate to be the same as the associated project's rate
    self.fee_percentage = project.fee_percentage if project.present?
  end

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