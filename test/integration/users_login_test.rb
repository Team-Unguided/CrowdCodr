require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # set-up a user for testing purposes
  # using the fixtures in test/fixtures/users.yml
  def setup
    @user = users(:jay)
  end
  
  test "login with invalid information" do
    get login_path                  # go to log-in page
    assert_template 'sessions/new'  # assert login page template
    post login_path, session: { username: "", password: "" } #give invalid info
    assert_template 'sessions/new'  # make sure you remained in log-in page
    assert_not flash.empty?         # assert the error message was flashed
    get root_path                   # go to homepage
    assert flash.empty?             # assert flashed message does not persist
  end
  
  
  test "login with valid information followed by logout" do
    get login_path              # go to log-in page
    # pass in a valid username/password combination
    post login_path, session: { username: @user.username, password: 'password' }
    assert is_logged_in?  # check user did get logged in
    # check user was redirected to profile page
    assert_redirected_to "/users/#{@user.username}" 
    follow_redirect!
    assert_template 'users/show'
   
    # the following asser_selects are commented out for now
    # because the functionality they test for is not yet implemented
    # they test that:
    #     1. log-in link does NOT appear once logged in (simple implementaion done)
    #     2. logout link DOES appear once logged in (simple implementaion done)
    #     3. link to user's profile page DOES appear when logged in
    #
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    #assert_select "a[href=?]", "/users/#{@user.username}"
    
    delete logout_path          # log out as user
    assert_not is_logged_in?    # assert the user was actually logged out
    
    # make sure user was redirected to homepage
    assert_redirected_to root_url
    follow_redirect!
   
    # the following asser_selects are commented out for now
    # because the functionality they test for is not yet implemented
    # they test that:
    #     1. log-in link does appear once logged out (simple implementaion done)
    #     2. logout link does NOT appear once logged out (simple implementaion done)
    #     3. link to user's profile page does NOT appear when logged out
    #
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    #assert_select "a[href=?]", "/users/#{@user.username}", count: 0
  end
end
