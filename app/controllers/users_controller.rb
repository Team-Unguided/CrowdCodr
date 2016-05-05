class UsersController < ApplicationController
  
  def show # for root/users/:id
    @user = User.find_by(username: params[:id])
    @userid = User.find_by(id: params[:id])
    @listings = Listing.all
    
    # redirect to root unless username is found
    # i.e. redirect to root if @user with supplied username is nil
    redirect_to(root_url) unless @user || @userid
    #stores user if id was used to find user
    @user = @userid if @userid
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params) #user_params is a private function
    if @user.save # upon successful insertion of new user into database
      log_in @user  # log-in as the new user out of courtesy
      flash[:success] = "SUCCESSFUL SIGN-UP MESSAGE!" # let the user know
      redirect_to("/users/#{@user.username}") # redirect to user's profile page

    # if insertion failed because of invalid input(s)
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_edit)
      # Handle a successful update.
    else
      render 'edit'
    end
  end
  
  def index #for searching
    @users = User.all
    #filter users by search term, and sort by time created
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC") 
      else
      @users = User.all.order('created_at DESC')
    end
  end
  
  private
    #for users#create
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email,
                                   :password, :password_confirmation)
    end
    
    #for users#update
    def user_params_edit
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end
end
