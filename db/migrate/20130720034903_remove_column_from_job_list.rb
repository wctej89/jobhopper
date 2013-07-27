class RemoveColumnFromJobList < ActiveRecord::Migration
  def change
    remove_column :job_lists, :status_id
  end
end
