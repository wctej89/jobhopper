require 'spec_helper'

describe UserTag do
  let(:user) { FactoryGirl.create(:user) }
  let(:tag) { FactoryGirl.create(:tag) }
  let(:user_tag) { user.user_tags.build(:tag_id => tag.id) }

  subject { user_tag }

  it { should be_valid }

  # describe "accessible attributes" do
  #   it "should not allow access to user id" do
  #     expect do
  #       UserTag.new(user_id: user.id)
  #     end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  #   end    
  # end  
end

