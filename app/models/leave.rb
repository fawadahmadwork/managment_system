class Leave < ApplicationRecord
  belongs_to :employee
  before_create :set_end_date
  before_create :set_half_days
  before_create :set_full_day
  validate :check_marriage_hajj_leave, on: :create
  validate :check_sick_and_urgent_work_leave_limit, on: :create

def check_sick_and_urgent_work_leave_limit
  if category == 'Paid' && %w[Sick Urgent_Work].include?(leave_type)
    remaining_leave_limit = leave_type == 'Sick' ? 10.5 : 5
    remaining_leave_limit -= employee.leaves
                                       .where(leave_type: leave_type, status: 'Approved')
                                       .where("DATE_PART('year', start_date) = ?", Time.now.year)
                                       .sum(:leave_days)
    if leave_days.to_f > remaining_leave_limit
      errors.add(:base, "Cannot save leave. Employee has exceeded the maximum #{leave_type.downcase.gsub('_', ' ')} leave limit.")
    end
  end
end


  def set_end_date
    if start_date.present? && duration == 'One_Day'
      self.end_date = start_date
      self.leave_days = 1
    end
  end

   def set_full_day
    if duration == 'Long_Leave'
      
      self.duration_type = 'Full_Day'
    end
  end

  def set_half_days
   if duration == 'One_Day' && duration_type == 'Half_Day'
    self.leave_days = leave_days / 2.0
   end
  end


  
  def check_marriage_hajj_leave
    if category == 'Paid' &&  %w[Marriage Hajj].include?(leave_type) && employee.leaves.exists?(leave_type: leave_type, status: 'Approved')
    errors.add(:base, " Employee already has an approved #{leave_type} leave.<br> Apply in Unpaid category".html_safe)
    end
  end
end
