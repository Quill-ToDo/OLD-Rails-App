class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :due, presence: true
  
  validate :due_and_start_datetimes?
  validate :due_after_start?

  def due_and_start_datetimes?
    errors.add(:due, 'due date must be a datetime') unless due.instance_of? DateTime
    if !start.nil?
        errors.add(:start, 'start date must be a datetime') unless start.instance_of? DateTime
    end
  end
  def due_after_start?
    errors.add(:due, 'due date must be after start date') if !start.nil? && !due.after?(start)
  end
end
