require 'spec_helper'

describe JobList do
  let(:user) { FactoryGirl.create(:user)}
  let(:list) { FactoryGirl.create(:list, :user_id => user.id)}
  let(:job)  { FactoryGirl.create(:job)}
  let(:list_job) { list.job_lists.build(:job_id => job.id)}
 
  describe "adding job to queue" do
    it "should not allow multiple instances of same job in user's list" do
      expect do
        list.job_list.build(:job_id => job.id)
      end.to raise_error
    end
  end


end
