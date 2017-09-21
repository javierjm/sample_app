require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup 
  	@micropost = microposts(:orange)
  end

  test "should redirect create when not logged in" do
  	post microposts_path, params: {micropost: {content: "Lorem ipsum"}}
  	assert_redirected_to login_url #login path
  end

  test "should redirect destroy when not logged in" do
  	assert_no_difference 'Micropost.count' do
  		delete micropost_path(@micropost)
  	end
  	assert_redirected_to login_url #login path
  end

end
