class Leave < ApplicationRecord
  belongs_to :employee
  before_create :set_end_date_and_total_days

  private

  def set_end_date_and_total_days
    if start_date.present? && duration == 'One_Day'
      self.end_date = start_date
     self.total_days = duration_type == 'Half_Day' ? total_days / 2.0 : total_days
    end
  end
end