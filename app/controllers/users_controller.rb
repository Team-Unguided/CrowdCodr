class UsersController < ApplicationController
  
  def show # for root/users/:id
    @user = User.find_by(username: params[:id])
    redirect_to(root_url) unless @user # redirect to root unless username is found
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params) #user_params is a private function
    if @user.save
      flash[:success] = "SUCCESSFUL SIGN-UP MESSAGE!"
      redirect_to("/users/#{@user.username}")
    else
      render 'new'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email,
                                   :password, :password_confirmation)
    end
end
