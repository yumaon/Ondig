require "test_helper"

class Artist::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get artist_profiles_show_url
    assert_response :success
  end

  test "should get edit" do
    get artist_profiles_edit_url
    assert_response :success
  end
end
