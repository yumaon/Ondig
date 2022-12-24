require "test_helper"

class Public::ArtistUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_artist_users_index_url
    assert_response :success
  end
end
