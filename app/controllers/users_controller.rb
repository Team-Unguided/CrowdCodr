class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update,:following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  
  def show # for root/users/:id
    @user = User.find_by(username: params[:id])
    @userid = User.find_by(id: params[:id])
    @listings = Listing.all
    @projects = Project.all
    # redirect to root unless username is found
    # i.e. redirect to root if @user with supplied username is nil
    redirect_to(root_url) unless @user || @userid
    #stores user if id was used to find user
    @user = @userid if @userid
    if @user.reviews.blank?
      @average_review = 0
    else
      @average_review = @user.reviews.average(:rating).round(2)
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params) #user_params is a private function
    @user.description = "My name is #{@user.first_name} #{@user.last_name}. "
    @user.description += "This is the default profile description."
    if @user.save # upon successful insertion of new user into database
      log_in @user  # log-in as the new user out of courtesy
      flash[:success] = "Sign-up successful!" # let the user know
      redirect_to("/users/#{@user.username}") # redirect to user's profile page

    # if insertion failed because of invalid input(s)
    else
      render 'sessions/new'
      #redirect_to login_path(anchor: 'signupTab')
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_edit)
      flash[:success] = "Successfully updated profile!" # let the user know
      redirect_to("/users/#{@user.username}") # redirect to user's profile page
    else
      render 'edit'
    end
  end
  
   def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def index #for searching
    @users = User.all # initialize results to all users
    
    @query = User.search do
      fulltext params[:query] # full text search
      with(:zipcode, params[:zipcode]) if (params[:zipcode]).present?
      order_by :avg_review, :desc # sort by avg review score
      order_by :review_count, :desc #order equal rating by number of reviews
    end
    @users = @query.results
    
  end
  
  private
    #for users#create
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email,
                                   :password, :password_confirmation)
    end
    
    #for users#update
    def user_params_edit
      params.require(:user).permit(:first_name, :last_name, :email, :description,
                                   :password, :password_confirmation, :picture,
                                   :zipcode)
    end

# BEFORE ACTIONS

    # Confirms the user is logged in.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms current user is logged in as the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
