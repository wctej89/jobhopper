class AddLocationToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :lat, :float
    add_column :jobs, :lng, :float
  end
end
