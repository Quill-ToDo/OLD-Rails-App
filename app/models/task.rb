# Task model
class Task < ApplicationRecord
  belongs_to :user
  has_many :labels
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :due, presence: true
  validate :start_not_after_due?

  scope :get_user, -> { where('user_id = ?', Current.user.id) }
  scope :find_task, -> { find(params[:id]) }
  scope :today, ->(position, equality) { where("#{position} #{equality} ?", DateTime.now.to_date.to_formatted_s(:db)) }
  scope :tomorrow, lambda { |position, equality|
                     where("#{position} #{equality} ?", DateTime.now.to_date.tomorrow.to_formatted_s(:db))
                   }
  scope :from_params, ->(position, equality, to_datetime) { where("#{position} #{equality} ?", to_datetime) }
  scope :order_by_due, ->(direction) { order("complete ASC, due #{direction}") }

  def complete_task
    self.complete = !complete
  end

  private

  def start_not_after_due?
    errors.add(:due, 'start must not come after the due date') if !start.nil? && !due.nil? && start.after?(due)
  end
end
