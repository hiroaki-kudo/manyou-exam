class AddIndexToTasks < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, [:name, :detail, :end_date, :status]
  end
end
