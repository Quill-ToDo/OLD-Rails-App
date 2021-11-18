# Task model
class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :due, presence: true
  validate :start_not_after_due?

  def complete_task
    self.complete = !complete
  end

  private

  def start_not_after_due?
    errors.add(:due, 'start must not come after the due date') if !start.nil? && !due.nil? && start.after?(due)
  end
end
