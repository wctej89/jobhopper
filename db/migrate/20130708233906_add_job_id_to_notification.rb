class AddJobIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :job_id, :integer
  end
end
