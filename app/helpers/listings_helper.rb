module ListingsHelper
  #Returns true if current user is owner of listing
  def is_owner?(listing)
    if logged_in?
      listing.user_id == current_user.id
    else
      false
    end
  end
  
  # Returns true if the currnet profile owns the listing
  def on_profile?(user, listing)
    listing.user_id == user.id
  end
end
