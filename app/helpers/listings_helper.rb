module ListingsHelper
  #Returns true if current user is owner of listing
  def is_owner?(listing)
    listing.user_id == current_user.id
  end
    
end
