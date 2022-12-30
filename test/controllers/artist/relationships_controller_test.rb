require "test_helper"

class Artist::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get followings" do
    get artist_relationships_followings_url
    assert_response :success
  end

  test "should get followers" do
    get artist_relationships_followers_url
    assert_response :success
  end
end
