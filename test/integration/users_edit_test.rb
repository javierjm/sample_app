require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

	def setup 
      @user = users(:javier)
	end

  test "update user with invalid email should fail" do
  	# get edit form (user)
    log_in_as(@user)

  	get edit_user_path(@user)
    assert_template 'users/edit'
  	# edit user attributes 
  	# patch form (user)
  	patch user_path(@user), params: { 	user:{ 	name: "", 
								  			  	email: "foo@invalid",
								  				password:"foo",
								  				password_confirmation:"bar"
								  			}
								  	}
  	# assert_ error flash 
	assert_template 'users/edit'
	assert_select "div.alert", "The form contains 4 errors.", count:1
  end

  test "successful edit with friendly forwarding" do

  get edit_user_path(@user)
  log_in_as(@user)
  assert_redirected_to edit_user_url(@user)

  

  	email = "javierjaram@gmail.com"
  	patch user_path(@user), params: { 	user:{ 	name: "Javier Jara", 
								  			  	email: email,
								  				password:"",
								  				password_confirmation:""
								  			}
								  	}

  	assert_not flash.empty?

  	assert_redirected_to @user
  	@user.reload 

  	assert_equal "Javier Jara", @user.name
  	assert_equal email, @user.email

	end


end
