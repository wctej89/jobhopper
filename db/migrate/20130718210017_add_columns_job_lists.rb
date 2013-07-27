class AddColumnsJobLists < ActiveRecord::Migration
  def change
   add_column :job_lists, :notes, :text, default: " "
   remove_column :job_lists, :status
   add_column :job_lists, :status_id, :integer
  end
end
