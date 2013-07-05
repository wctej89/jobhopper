class AddUniquenessToJobList < ActiveRecord::Migration
  def change
    add_index :job_lists, [:job_id, :list_id], unique: true
  end
end
