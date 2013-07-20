class AddStatusBack < ActiveRecord::Migration
 def change
 	add_column :job_lists, :status, :string, default: "pending"
 end
end
