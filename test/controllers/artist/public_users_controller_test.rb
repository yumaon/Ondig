require "test_helper"

class Artist::PublicUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get artist_public_users_show_url
    assert_response :success
  end
end
