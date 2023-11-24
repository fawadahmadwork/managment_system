class Leave < ApplicationRecord
  belongs_to :employee
  before_create :set_end_date
  before_create :set_half_days

  private

  def set_end_date
    if start_date.present? && duration == 'One_Day'
      self.end_date = start_date
      self.total_days = 1
   
    end
  end
   def set_half_days
    self.total_days = duration_type == 'Half_Day' ? total_days / 2.0 : total_days
  end
end