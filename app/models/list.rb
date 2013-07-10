class List < ActiveRecord::Base
  attr_accessible :user_id
  has_many :job_lists
  has_many :jobs, :through => :job_lists
  belongs_to :user

  def add_job(id)
    job = Job.find(id)
    self.job_lists.create(:list_id => self.id, :job_id => job.id, :status => "pending")
  end

  def remove!(id)
    JobList.find_by_list_id_and_job_id(self.id, id).destroy
  end
end
