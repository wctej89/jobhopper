require 'spec_helper'

describe UsersController do

  let(:user) {create(:user)}

  describe "get #new" do
    it "should render the new template" do
      get :new
      response.should render_template(:new)
    end

    it "should assign a new user object as @user" do
      get :new
      assigns(:user).should be_an_instance_of(User)
    end
  end

  describe "post #Create" do

    context "with valid attributes" do
      it "should create a new user" do
        expect{post :create, user: attributes_for(:user)}.to change(User, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create a new user" do
        expect{post :create, :user => attributes_for(:user, :email => "")}.to_not change(User, :count).by(1) 
      end
    end
  end

  describe "get #edit" do
    context "when not logged in" do
      it "should not allow you to get there" do
        expect{get :edit}.to raise_error
      end
    end

    context "when logged in" do
      it "should render the page" do
        pending
        get :edit, id: user.id
        response.should render_template(:edit)
      end
    end
  end

  describe "put #update" do
    let(:new_user) { create(:user, :email => "foo@bar.com") }

    it "should update the user with the new params" do
      pending
      put :update, user: attributes_for(:user, :email => "baz@bok.com")
      new_user.email.should == "baz@bok.com"
    end
  end

end
