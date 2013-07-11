require 'spec_helper'

describe Notification do
  let(:user) { FactoryGirl.create(:user) }
  let(:job) { FactoryGirl.create(:job) }
  let(:notification) { FactoryGirl.create(:notification, :user_id => user.id, :job_id => job.id, :subject => job.name)}

  describe "accessible attributes" do
    subject { notification }

    it { should respond_to(:user) }
    it { should respond_to(:subject) }
  end

  describe "validations" do
    let(:notification_without_user) { FactoryGirl.create(:notification, :user_id => '', :job_id => job.id)}

    it "should not be valid" do 
      expect { notification_without_user.save }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
