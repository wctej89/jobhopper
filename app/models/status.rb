class Status < ActiveRecord::Base
	belongs_to :job_list
	attr_accessible :status, :date
end