class Status < ActiveRecord::Base
	belongs_to :job_list
	attr_accessible :status, :date, :job_list_id 
end