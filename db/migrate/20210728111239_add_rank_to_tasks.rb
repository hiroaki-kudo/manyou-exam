class AddRankToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :rank, :integer
    Task.update_all(rank: 0)
    change_column_null :tasks, :rank, false
  end
end
