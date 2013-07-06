class UsersController < ApplicationController

  before_filter :find_user, :only => [:edit, :show, :feed]
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

  def feed
    # TODO Benchmark this 
    page = params[:page].to_i
    #TODO think about background workers here... two+ indexes
    results = current_user.feed
    render :json => paginate(results, page)
  end

  private 

  def paginate(array, page)
    start_index = (page-1) * 20
    response = {}
    response[:total] = array.count
    response[:total_pages] = array.count/20
    response[:results] = array[start_index...(start_index+20)]
  end

  def find_user
    @user = User.find(params[:id])
  end

end
