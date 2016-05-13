class ReviewsController < ApplicationController
before_action :find_user

  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(review_params)
    @review.subject_id = current_user.id
    @review.user_id = @user.id
    
    if @review.save
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  private
  
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
  
    def find_user
      @user = User.find_by(id: params[:user_id])
    end
  
end
