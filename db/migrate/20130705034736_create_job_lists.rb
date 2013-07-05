class CreateJobLists < ActiveRecord::Migration
  def change
    create_table :job_lists do |t|
      t.references :list
      t.references :job
      t.string :status
      t.timestamps
    end
  end
end