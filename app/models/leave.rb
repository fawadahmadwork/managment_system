class Leave < ApplicationRecord
  belongs_to :employee
  validates :leave_type, :category, :duration,  :start_date, :status, :employee_id, presence: true
  validate :check_leave_overlap, on: :create
  validate :start_date_within_current_month
  validate :end_date_greater_than_start_date
  validate :check_marriage_hajj_leave, on: :create
  validate :check_sick_and_urgent_work_leave_limit, on: :create
  validate :employee_probation_completed
  before_create :set_end_date
  before_create :set_half_days
  before_create :set_full_day



  def check_sick_and_urgent_work_leave_limit
    if category == 'Paid' && %w[Sick Urgent_Work].include?(leave_type)
    remaining_leave_limit = leave_type == 'Sick' ? 10 : 5
    remaining_leave_limit += 0.5 if duration_type == 'Half_Day'
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



  def start_date_within_current_month
   if start_date.present? && start_date < Time.zone.now.beginning_of_month

      errors.add(:start_date, 'must be in the current month')
    end
  end

  def end_date_greater_than_start_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add(:end_date, 'must be greater than the start date')
    end
  end

 def employee_probation_completed
    unless employee.probation_period == 'completed'
      errors.add(:base, "Cannot apply for leave. Probation period must be completed.")
    end
  end



def check_leave_overlap
  if start_date.present?
    overlapping_leave = employee.leaves.where(
      '(? BETWEEN COALESCE(start_date, ?) AND COALESCE(end_date, ?)) OR (? BETWEEN COALESCE(start_date, ?) AND COALESCE(end_date, ?))',
      start_date, Time.now.beginning_of_day, Time.now.end_of_day, end_date, Time.now.beginning_of_day, Time.now.end_of_day
    ).where(status: 'Approved')

    if overlapping_leave.exists?
      errors.add(:base, 'Cannot apply for leave. Employee already has an approved leave during the specified date range.')
    end
  end
end




end