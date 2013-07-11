require 'spec_helper'

describe City do

  let(:city) { FactoryGirl.create(:city) }

  describe "accessible attributes" do
    it { should respond_to(:name)}
    it { should respond_to(:latitude)}
    it { should respond_to(:longitude)}
    it { should respond_to(:jobs)}
  end
  
end
