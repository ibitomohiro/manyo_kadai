class AddDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :dead_line, :datetime, null: false, default: DateTime.now
  end
end
