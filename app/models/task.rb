# Task model
class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :due, presence: true
  validate :due_after_start?

  def complete_task
    self.complete = !complete
  end

  private

  def due_after_start?
    errors.add(:due, 'due date must be after start date') if !due.nil? && (!start.nil? && !due.after?(start))
  end
end
