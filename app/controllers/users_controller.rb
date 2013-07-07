class UsersController < ApplicationController

  before_filter :find_user, :only => [:edit, :show, :feed]
  before_filter :check_user_id, :only => [:edit]
  before_filter :logged_in?, :only => [:new, :create]
  
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
    if @user.update_attributes(para ms[:user])
      flash[:success] = "Profile Updated"
      redirect_to(@user)
    else
      render 'edit'
      flash[:errors] = @user.errors.full_messages
    end
  end

  def show
    @skills = current_user.tags
    @tags = Tag.limit(10)
  end

  def feed
    if params[:page]
      page = params[:page].to_i
    else
      page = 1
    end
    location = get_location
    @queue = current_user.jobs
    @jobs = get_results(location, page)[:results]
  end

  private 

  def get_results(location, page)
    current_user.feed(location, page)
  end

  # def paginate(array, page)
  #   start_index = (page-1) * 20
  #   response = {}
  #   response[:total] = array.count
  #   response[:total_pages] = array.count/20
  #   response[:results] = array[start_index...(start_index+100)]
  # end

  def find_user
    @user = User.find(params[:id])
  end

end
