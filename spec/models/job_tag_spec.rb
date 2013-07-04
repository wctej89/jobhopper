require 'spec_helper'

describe JobTag do
  let(:job) { FactoryGirl.create(:job) }
  let(:tag) { FactoryGirl.create(:tag) }
  let(:job_tag) { job.tags << tag }

  subject { job_tag.first }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to job id" do
      expect do
        JobTag.new(job_id: job.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end  
end

