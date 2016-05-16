class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # find the user by username
    user = User.find_by(username: params[:session][:username])
    @user = User.new if @user.blank?
    
    # if user exists && is authenticated by given password (i.e. correct passwd)
    if user && user.authenticate(params[:session][:password])
      # log-in as user using log_in() found in sessions_helper.rb
      log_in user
      # redirect to user's profile page
      redirect_back_or "/users/#{user.username}"
      
    # otherwise, invalid username/password combination was entered
    else
      # let the user know input was invalid
      # flash.now is used instead of simple flash
      # because render 'new' does not count as a new request, message should be
      # flashed with the current page, NOT the next requested pag
      flash.now[:danger] = 'Invalid username/password combination!!!'
      
      # re-render the log-in page
      render 'new'
    end
  end

  def destroy
    # log out as user using log_out() found in sessions_helper.rb
    log_out
    # redirect to homepage after logging out
    redirect_to root_url
  end
end