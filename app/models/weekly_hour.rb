class WeeklyHour < ApplicationRecord
  belongs_to :project

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :external_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }

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
    start_date = created_at.beginning_of_week
    end_date = created_at.end_of_week(:saturday)

    # Check if the week starts in the previous month
    if start_date.month != created_at.month
      # If three or more days are in the previous month, consider it the last week of that month
      if start_date.day >= 3
        start_date = created_at.beginning_of_week.prev_month
      end
    end

    # Format the date range
    "#{ordinal_week_number}   #{start_date.strftime('%b')}  #{start_date.strftime('%d/%m/%y')} to #{end_date.strftime('%d/%m/%y')}"
  end


  def ordinal_week_number
    day_of_month = created_at.day
    week_number = (day_of_month - 1) / 7 + 1
    ordinal = case week_number % 10
              when 1 then "#{week_number}st"
              when 2 then "#{week_number}nd"
              when 3 then "#{week_number}rd"
              else "#{week_number}th"
              end

    "#{ordinal} week"
  end
end
