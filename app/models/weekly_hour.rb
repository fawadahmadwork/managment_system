class WeeklyHour < ApplicationRecord
  belongs_to :project
 before_validation :set_default_date
  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :external_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
 
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

#   def date_range
#     start_date = created_at.beginning_of_week
#     end_date = created_at.end_of_week(:saturday)

#     # Check if the week starts in the previous month
#     if start_date.month != created_at.month
#       # If three or more days are in the previous month, consider it the last week of that month
#       if start_date.day >= 3
#         start_date = created_at.beginning_of_week.prev_month
#       end
#     end
#      week_number = start_date.strftime('%U').to_i + 1 # Adding 1 to get the week number starting from 1
# week_within_month = ((start_date.day - 1) / 7).to_i + 1

#  "#{week_within_month.ordinalize} week (#{start_date.strftime('%b')} #{start_date.strftime('%d')} to #{end_date.strftime('%b')}  #{end_date.strftime('%d')}) "

#   end
#   
def date_range
  return "Date not available" if date.nil?

  start_date = date.beginning_of_week
  end_date = date.end_of_week(:saturday)

  # Check if the week starts in the previous month
  if start_date.month != date.month
    # If three or more days are in the previous month, consider it the last week of that month
    if start_date.day >= 3
      start_date = date.beginning_of_month.beginning_of_week
    end
  end

  week_number = start_date.strftime('%U').to_i + 1 # Adding 1 to get the week number starting from 1
  week_within_month = ((start_date.day - 1) / 7).to_i + 1

  "#{week_within_month.ordinalize} week #{start_date.strftime('%b')} (#{start_date.strftime('%b %d')} to #{end_date.strftime('%b %d')})"
end




end
