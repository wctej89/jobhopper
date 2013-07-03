class UsersController < ApplicationController

  before_filter :find_user, :only => [:edit, :show]
  before_filter :check_user_id, :only => [:edit]
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Options IO"
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      redirect_to(@user)
    else
      render 'edit'
      flash[:errors] = @user.errors.full_messages
    end
  end

  def show
  end

  private 

  def find_user
    @user = User.find(params[:id])
  end

end
