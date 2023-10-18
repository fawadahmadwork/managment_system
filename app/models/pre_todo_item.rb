class PreTodoItem < ApplicationRecord
  belongs_to :employee

  before_save :update_done_at_if_done_changed

  private

  def update_done_at_if_done_changed
    if done_changed? && done?
      self.done_at = Time.zone.now
    elsif done_changed? && !done?
      self.done_at = nil
    end
  end
end
