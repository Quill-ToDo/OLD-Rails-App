class AddCompleteToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :complete, :boolean
  end
end
