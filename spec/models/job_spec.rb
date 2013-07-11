require 'spec_helper'

describe Job do
  
  let(:job) { FactoryGirl.create(:job) }

  subject { job }

  it { should respond_to(:name)}
  it { should respond_to(:description)}
  it { should respond_to(:email)}
  it { should respond_to(:company)}
  it { should respond_to(:source_url)}
  it { should respond_to(:lat)}
  it { should respond_to(:lng)}
  it { should respond_to(:city)}
  it { should respond_to(:job_tags)}
  it { should respond_to(:tags)}
  it { should respond_to(:lists)}


  describe "validations" do
    describe "job without a name" do
      let(:job_without_name) { FactoryGirl.create(:job, :name => "")}

      it "should not be valid" do
        expect { job_without_name.save }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "has_coordinates" do
    let(:job_without_coordinates) { FactoryGirl.create(:job, :lat => '', :lng => '') }

    it "should return false" do
      job_without_coordinates.has_coordinates.should == false
    end

    it "should return true" do
      job.has_coordinates.should == true
    end
  end

  describe "has city?" do
    let(:city) { FactoryGirl.create(:city) }
    
    before do 
      job.city = city
    end

    it "should return the city" do
      job.city.should == city
    end
  end

end
