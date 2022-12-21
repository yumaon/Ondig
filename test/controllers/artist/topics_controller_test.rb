require "test_helper"

class Artist::TopicsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get artist_topics_new_url
    assert_response :success
  end

  test "should get index" do
    get artist_topics_index_url
    assert_response :success
  end

  test "should get show" do
    get artist_topics_show_url
    assert_response :success
  end

  test "should get edit" do
    get artist_topics_edit_url
    assert_response :success
  end
end
