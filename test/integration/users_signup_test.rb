require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "user signup should be invalid" do 
  	get signup_path

  	assert_no_difference 'User.count' do 
  		post signup_path, params: { user: {name: "", 
  										 email: "user@invalid", password: "foo", password_confirmation: "bar"}}
  	end

  	assert_template 'users/new'

  end

  test "invalid signup should display error messages" do 
    get signup_path

    assert_no_difference 'User.count' do 
      post signup_path, params: { user: {name: "", 
                       email: "user@invalid", password: "foo", password_confirmation: "bar"}}
    end

    assert_template 'users/new'

    assert_template layout: "layouts/application", partial: "_error_messages"
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
  
end