class AddUniquenessToJobList < ActiveRecord::Migration
  def change
    add_index :job_lists, :job_id, unique: true
  end
end
