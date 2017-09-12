require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
   def setup 
      @base_title = 'Ruby on Rails Tutorial Sample App'
      @user = users(:javier)
  end

  test "login with invalid information" do 
  	get login_path
  	assert_select "title", full_title("Log In")
  	assert_template 'sessions/new'
  	#assert_select "title", "Login | #{@base_title}"
  	post login_path params: {session: {email:" ", password:" "} }
  	assert_template 'sessions/new'
  	assert_not flash.empty?, "Flashes in Log In are empty"
  	get root_path
  	assert flash.empty?, "Flashes in root are not empty"
  end

   test "login with valid information" do 
  	get login_path
  	assert_select "title", full_title("Log In")
  	assert_template 'sessions/new'
  	#assert_select "title", "Login | #{@base_title}"
  	post login_path, params: {session: {email:@user.email, password:"123456"} }
    assert_redirected_to @user

  	follow_redirect!
  	assert_template 'users/show'

  	assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

 test "login with valid information and then logout" do 
    get login_path
    post login_path, params: {session: {email:@user.email, password:"123456"} }
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path, count:1
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    #assert_equal cookies['remember_token'], assigns(:user).remember_token

    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end

 end