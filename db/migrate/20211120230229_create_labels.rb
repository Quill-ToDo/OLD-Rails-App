class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: true, foreign_key: true

      t.timestamps
    end
  end
end
