class AddEndToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :end_date, :date
    Task.update_all(end_date: DateTime.now)
    change_column_null :tasks, :end_date, false
    # default: 'DateTime.now' , null: false
    # change_column_null :tasks, :end, :date, null: false
    # change_column_default :tasks, :end, :date, default: 'now()'
  end
end
