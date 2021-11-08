class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :due, presence: true
  validate :due_after_start?

  def self.default_sort
    tasks = Task.order('due DESC')
  end

  def complete_task
    self.complete = !self.complete
  end

  private
  def due_after_start?
    if !due.nil?
      errors.add(:due, 'due date must be after start date') if !start.nil? && !due.after?(start)
    end
  end
end
