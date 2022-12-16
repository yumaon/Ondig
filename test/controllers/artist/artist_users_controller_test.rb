require "test_helper"

class Artist::ArtistUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get artist_artist_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get artist_artist_users_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get artist_artist_users_unsubscribe_url
    assert_response :success
  end
end
