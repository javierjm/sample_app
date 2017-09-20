require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup 
  	@user = users(:javier)
  	#@micropost = Micropost.new(content:"Lorem ipsum", user_id: @user.id)
  	#After associating the micropost and user by methods: belongs_to and has_many respectively we can create a micropost with build method, like this: 
  	@micropost = @user.microposts.build(content: "Lorem ipsum") 
  end

  test "should be valid" do 
  	assert @micropost.valid?
  end

  test "user id should be present" do 
  	@micropost.user_id = nil 
  	assert_not @micropost.valid?
  end

  test "content should be present" do 
  	@micropost.content = "  "
  	assert_not @micropost.valid? 
  end

  test "content should be at most 140 characters" do 
  	@micropost.content = "a"*142
  	assert_not @micropost.valid?
  end

	test "order should be most recent first" do
	  assert_equal microposts(:most_recent), Micropost.first
	end
end
