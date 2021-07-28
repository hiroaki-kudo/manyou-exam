class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :integer
    Task.update_all(status: "選択")
    change_column_null :tasks, :status, false
  end
end
