class Task < ApplicationRecord
  validates :title, presence: true
  validates :start, presence: true
  validate :due_after_start?

  def due_after_start?
    errors.add(:due, 'due date must be after start date') if !due.nil? && !due.after?(start)
  end
end
