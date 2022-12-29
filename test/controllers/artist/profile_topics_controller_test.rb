require "test_helper"

class Artist::ProfileTopicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artist_profile_topics_index_url
    assert_response :success
  end

  test "should get show" do
    get artist_profile_topics_show_url
    assert_response :success
  end
end
