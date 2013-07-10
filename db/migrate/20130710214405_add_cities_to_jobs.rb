class AddCitiesToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :city_id, :integer
  end
end
