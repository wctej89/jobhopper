require 'spec_helper'

describe Tag do
  let(:tag) { FactoryGirl.create(:tag) }

  describe "accessible attributes" do
    subject { tag }

    it { should respond_to(:name)}

    it { should respond_to(:user)}
    it { should respond_to(:job)}
  end
end
