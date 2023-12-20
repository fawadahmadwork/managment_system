class Leave < ApplicationRecord
  attr_accessor :half_day
  belongs_to :employee
  validates :leave_type, :category, :duration,  :start_date, :status, :employee_id, presence: true
  validate :validate_leave_limit, on: :create
  validate :check_leave_overlap, on: :create
  validate :start_date_within_current_month
  validate :end_date_greater_than_start_date
  validate :check_marriage_hajj_leave, on: :create
  validate :employee_probation_completed, on: :create, if: -> { category == 'Paid' }
  before_create :set_end_date
  before_create :set_full_day
  before_create :set_duration_type
  before_create :leave_days_half  

# before create


   def set_end_date
    if start_date.present? && duration == 'One_Day'
      self.end_date = start_date
    end
  end

  def set_full_day
   self.duration_type = 'Full_Day' unless duration_type == 'Half_Day'
  end

 def set_duration_type
    self.duration_type = 'Half_Day' if half_day== '1'
  end

  def leave_days_half
     if half_day== '1'
     self.leave_days = '0.5'
     end
  end

# validations

   

  
 

  
  def check_marriage_hajj_leave
    if category == 'Paid' &&  %w[Marriage Hajj].include?(leave_type) && employee.leaves.exists?(leave_type: leave_type, status: 'Approved')
    errors.add(:base, " Employee already has an approved #{leave_type} leave.<br> Apply in Unpaid category".html_safe)
    end
  end




  def start_date_within_current_month
    if start_date.present? && (start_date < Time.zone.now.beginning_of_month || start_date > (Time.zone.now + 3.months).end_of_month)
      errors.add(:start_date, 'must be within the current month and the coming 3 months')
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



def validate_leave_limit
    return unless employee.present?

    if leave_type == 'Sick' && category == 'Paid'
      remaining_sick_leaves = employee.sick_leaves_limit - employee.sick_leaves_taken

      if leave_days > remaining_sick_leaves
        errors.add(:base, "Cannot exceed remaining sick leave limit).")
      end
    elsif leave_type == 'Urgent_Work' && category == 'Paid'
      remaining_urgent_leaves = employee.urgent_leaves_limit - employee.urgent_leaves_taken

      if leave_days > remaining_urgent_leaves
        errors.add(:base, "Cannot exceed remaining urgent leave limit")
      end
    end
    # Add similar checks for other leave types if needed
  end


 

end