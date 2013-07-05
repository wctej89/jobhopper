require 'spec_helper'

describe List do
  let(:list) { FactoryGirl.create(:list) }

  describe "accessible attributes" do
    subject { list }

    it { should respond_to (:user_id) }

  end
end
