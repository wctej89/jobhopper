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
    location = get_location
    tags = current_user.tags
    @queue = current_user.list.jobs
    page = 1
    @jobs = paginate(get_results([cookies["lat"], cookies["lon"]]), page)
    CraigslistWorker.perform_async(tags, location)
  end

  def results
    location = get_location
    CraigslistWorker.perform_async(current_user)
    page = params[:page].to_i
    results = get_results([cookies["lat"], cookies["lon"]])
    render :json => paginate(results, page)
  end

  private 


  def get_results(location)
    current_user.feed(location)
  end

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
