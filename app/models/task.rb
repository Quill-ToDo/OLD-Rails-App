class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :due, presence: true
  validate :due_after_start?

  private
  def due_after_start?
    if !due.nil?
      errors.add(:due, 'due date must be after start date') if !start.nil? && !due.after?(start)
    end
  end
end