require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jay)
  end

# try editing user info with invalid information
# should return to edit form
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { first_name:  "",
                                    last_name: "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end
  
# try editing user info with valid information
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    first_name  = "NotJay"    # new first_name will be NotJay
    last_name = "NotSong"     # new last_name will be NotSong 
    email = "foo@bar.com"     # new email will be foo@bar.com
    patch user_path(@user), user: { first_name:  first_name,
                                    last_name: last_name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?    # make sure success message is flashed
    assert_redirected_to "/users/#{@user.username}"
    @user.reload    #reload @user from database after update
    # make sure the reloaded user from database has right information saved
    assert_equal first_name,  @user.first_name
    assert_equal last_name,  @user.last_name
    assert_equal email, @user.email
  end
end
