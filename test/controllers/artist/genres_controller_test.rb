require "test_helper"

class Artist::GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artist_genres_index_url
    assert_response :success
  end
end
