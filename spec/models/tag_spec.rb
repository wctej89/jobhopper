require 'spec_helper'

describe Tag do
  let(:tag) { FactoryGirl.create(:tag) }

  describe "accessible attributes" do
    subject { tag }

    it { should respond_to(:name)}

    it { should respond_to(:users)}
    it { should respond_to(:jobs)}
  end

  describe "#is_location?" do
    let(:location_tag) { FactoryGirl.create(:tag, :tag_type => 'LocationTag') }

    it "should return false" do
      tag.is_location?.should == false
    end

    it "should return true" do
      location_tag.is_location?.should == true
    end
  end
end
