class ReviewsController < ApplicationController
before_action :find_user
before_action :find_review, only: [:edit, :update, :destroy]

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
  
  def destroy
    @review.destroy
    redirect_to user_path(@user)
  end
  
  def edit
  end
  
  def update
    if @review.update(review_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  private
  
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
  
    def find_user
      @user = User.find_by(id: params[:user_id])
    end
    
    def find_review
      @review = Review.find(params[:id])
    end
  
end
