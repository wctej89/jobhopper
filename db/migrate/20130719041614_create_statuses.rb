class CreateStatuses < ActiveRecord::Migration
	def change
		create_table :statuses do |t|
			t.string :status
			t.string :date

			t.timestamps
		end
	end
end
