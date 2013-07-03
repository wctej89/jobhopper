require 'spec_helper'

describe SessionsController do

  let(:user) { create(:user) }

  describe "get NEW" do
    it "should render the new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "post CREATE" do
    context "with valid attrs" do
      it "should sign the user in" do
        pending
        expect{post :create, :session => {:email => user.email }}.to change(session[:user_id])
      end
    end

    context "with invalid attrs" do
      it "should redirect the user back to the home page" do
        pending
        post :create, :session => {:email => user.email, :password => 'notfoobar'}
        response.should redirect_to root_path
      end
    end
  end

  describe "delete DESTROY" do
    before(:each) do
      log_in_user(user)
    end
    it "should clear the session" do
      pending
      expect{delete :destroy}.to change(session[:user_id]).from(1).to('')
    end

    it "should redirect to the homepage" do
      pending
      delete :destroy
      response.should redirect_to root_path
    end
  end
  
end
