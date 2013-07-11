require 'spec_helper'

describe User do

  let(:user) { build(:user) }

  subject { user }

  it { should respond_to(:name)}
  it { should respond_to(:email)}

  describe "accessible attributes" do

    describe "when email isn't present" do 
      before { user.email = "" }
      it { should_not be_valid }
    end

    describe "when email format is invalid" do 
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.com exampleuser@foo.]
        addresses.each { |invalid| user.email = invalid }
        user.should_not be_valid
      end
    end

    describe "when email format is valid" do 
      it "should be valid" do 
        addresses = %w[user@foo.COM US_ER@f.b.org frst.last@foo.jp]
        addresses.each { |valid_address| user.email = valid_address }
        user.should be_valid
      end
    end

    describe "when email address is already taken" do
      before do 
        user_with_same_email = user.dup
        user_with_same_email.email = user.email.upcase
        user_with_same_email.save
      end
      it { should_not be_valid }
    end

    describe "user emails should all be lowercase" do
      let(:mixed_case_email) { "Foo@BAR.CoM" }
      
      it "should save the email lowercased" do 
        user.email = mixed_case_email
        user.save
        user.reload.email.should == mixed_case_email.downcase
      end
    end

    describe "users from social providers" do

      before do 
        @auth_hash = set_linkedin_omniauth
      end

      it "should be able to build a user from the auth_hash" do
        linkedin_user = User.from_omniauth(@auth_hash)
        expect(linkedin_user.email).to eq(@auth_hash['info']['email'])
      end

      it "should create the user" do
        linkedin_user = User.from_omniauth(@auth_hash)
        linkedin_user.should be_valid
      end

      it "should add to the user's tags" do
        linkedin_user = User.from_omniauth(@auth_hash)
        linkedin_user.tags
      end
    end
  end

  describe "skills" do
    let(:tag) { build(:tag) }
    before do
      user.tags << tag
    end

    it "should pass back an array of skills" do
      user.skills.should == [tag]
    end
  end

  describe "locations" do
    let(:tag) { build(:tag, :tag_type => 'LocationTag') }

    before do 
      user.tags << tag
    end

    it "should pass back an array of locations" do
      user.locations.should == [tag]
    end
  end
end
