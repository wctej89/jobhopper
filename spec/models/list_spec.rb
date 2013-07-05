require 'spec_helper'

describe List do
  let(:list) { FactoryGirl.create(:list) }

  describe "accessible attributes" do
    subject { list }

    it { should respond_to (:user) }
    it { should respond_to (:job_lists)}
    it { should respond_to(:jobs)}
  end

  describe "#add_job" do
    let(:job) {FactoryGirl.create(:job)}

    it "should add the job to the list" do
      list.add_job(job.id)
      list.jobs.should_not be_empty
    end
  end

  describe "#remove job" do

    let(:job) { FactoryGirl.create(:job) }
    before do 
      list.add_job(job.id)
    end

    it "should remove the job from the list" do
      list.remove_job(job.id)
      list.jobs.should be_empty
    end
  end
end
