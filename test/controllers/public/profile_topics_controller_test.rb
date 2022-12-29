require "test_helper"

class Public::ProfileTopicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_profile_topics_index_url
    assert_response :success
  end
end
