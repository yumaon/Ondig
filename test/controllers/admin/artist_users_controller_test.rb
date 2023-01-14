require "test_helper"

class Admin::ArtistUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_artist_users_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_artist_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_artist_users_edit_url
    assert_response :success
  end
end
