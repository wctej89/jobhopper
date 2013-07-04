require 'spec_helper'

describe UserTag do
  let(:user) { FactoryGirl.create(:job) }
  let(:tag) { FactoryGirl.create(:tag) }
  let(:user_tag) { user.tags << tag }

  subject { user_tag.first }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to job id" do
      expect do
        JobTag.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end  
end

