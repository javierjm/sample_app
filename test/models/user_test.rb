require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup 
  	@user = User.new(name: "Javier Jara", email: "javier.jara@logn.co", 
  		                     password: "foobar", password_confirmation: "foobar") 

  end

  test "should be valid" do 
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "     "
  	assert_not @user.valid?
  end

  test "email should be present" do 
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "name should not be too long" do 
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end 

  test "email should not be too long" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid? 
  end

  test "email format is valid" do
  	valid_address = %w{user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn}
  	valid_address.each do |valid_address| 
  		@user.email = valid_address
  		assert @user.valid?, "#{valid_address.inspect} should be valid"
  	end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email must be unique" do 
  	duplicate_user = @user.dup 
  	duplicate_user.email = @user.email.upcase
  	@user.save 
  	assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do 
  	@user.email = "javier.JARA@logn.co"
  	@user.save 
  	copy = @user.reload 
  	assert_equal("javier.jara@logn.co", copy.email, "FUCK email is not downcase")
  end

  test "password should be present (nonblank)" do
  	@user.password = @user.password_confirmation = " " * 6 
  	assert_not @user.valid?
  end

  test "password should have a minimun lenght" do 
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?  
  end

end
