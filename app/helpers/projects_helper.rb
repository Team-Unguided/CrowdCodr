module ProjectsHelper
    
  # Returns true if the currnet profile owns the listing
  def on_profile_project?(user, project)
    project.user_id == user.id
  end
  
end
